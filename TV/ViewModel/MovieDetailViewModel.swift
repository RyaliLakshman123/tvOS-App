//
//  MovieDetailViewModel.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//


import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject {

    @Published private(set) var detail: MovieDetail?
    @Published private(set) var extras = MediaExtras()
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    let movieID: Int
    private var hasLoaded = false

    init(movieID: Int) {
        self.movieID = movieID
    }

    func load() async {
        guard !hasLoaded else { return }
        isLoading = true
        errorMessage = nil

        // Core details + all extras run in parallel. Only the core details can fail the page.
        async let core = TMDBDetailService.movieDetails(id: movieID)
        async let more = MediaExtras.load(kind: .movie, id: movieID)

        do {
            detail = try await core
            extras = await more
            hasLoaded = true
        } catch {
            errorMessage = "Couldn't load this movie. Check your connection and try again."
            print("❌ Movie detail error:", error)
        }
        isLoading = false
    }

    func retry() async {
        hasLoaded = false
        await load()
    }
}
