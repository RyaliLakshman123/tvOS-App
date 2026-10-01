//
//  TVShowDetailViewModel.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//


import Foundation
import Combine

@MainActor
final class TVShowDetailViewModel: ObservableObject {

    @Published private(set) var detail: TVShowDetail?
    @Published private(set) var extras = MediaExtras()
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    // Seasons / episodes
    @Published var selectedSeasonNumber: Int?
    @Published private(set) var episodesBySeason: [Int: [TMDBEpisode]] = [:]
    @Published private(set) var isLoadingEpisodes = false
    @Published private(set) var episodesFailed = false

    let showID: Int
    private var hasLoaded = false

    init(showID: Int) {
        self.showID = showID
    }

    var selectedEpisodes: [TMDBEpisode] {
        guard let n = selectedSeasonNumber else { return [] }
        return episodesBySeason[n] ?? []
    }

    func load() async {
        guard !hasLoaded else { return }
        isLoading = true
        errorMessage = nil

        async let core = TMDBDetailService.tvDetails(id: showID)
        async let more = MediaExtras.load(kind: .tv, id: showID)

        do {
            let d = try await core
            detail = d
            extras = await more
            hasLoaded = true
            isLoading = false

            // Open on the first real season.
            if let first = d.seasons.first {
                await selectSeason(first.seasonNumber)
            }
        } catch {
            errorMessage = "Couldn't load this show. Check your connection and try again."
            print("❌ TV detail error:", error)
            isLoading = false
        }
    }

    func retry() async {
        hasLoaded = false
        await load()
    }

    /// Loads (and caches) the episodes for a season.
    func selectSeason(_ number: Int) async {
        selectedSeasonNumber = number
        episodesFailed = false

        if episodesBySeason[number] != nil {
            isLoadingEpisodes = false
            return
        }

        isLoadingEpisodes = true
        do {
            let eps = try await TMDBDetailService.episodes(tvID: showID, season: number)
            episodesBySeason[number] = eps
        } catch {
            // A quick tap on another season cancels this task — that's not a failure.
            if !(error is CancellationError), (error as? URLError)?.code != .cancelled,
               selectedSeasonNumber == number {
                episodesFailed = true
                print("❌ Season \(number) error:", error)
            }
        }
        // Only the latest selection controls the spinner.
        if selectedSeasonNumber == number { isLoadingEpisodes = false }
    }
}
