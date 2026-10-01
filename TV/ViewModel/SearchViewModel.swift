//
//  SearchViewModel.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//


//  Powers the Search tab: free-text TMDB search + category (genre/keyword) browse.
//  Results are MediaContent (tagged with media type) so they reuse MediaDetailLink
//  and open the correct detail screen.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var query: String = ""
    @Published private(set) var results: [MediaContent] = []
    @Published private(set) var isLoading = false

    private let apiKey = TMDBConfig.apiKey
    private var searchTask: Task<Void, Never>?

    // MARK: - Free-text search (multi: movies + tv)

    func search(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        searchTask?.cancel()

        guard !trimmed.isEmpty else {
            results = []
            isLoading = false
            return
        }

        isLoading = true
        searchTask = Task {
            // small debounce so we don't fire on every keystroke
            try? await Task.sleep(nanoseconds: 350_000_000)
            if Task.isCancelled { return }

            guard let encoded = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&query=\(encoded)&include_adult=false")
            else { isLoading = false; return }

            let items = await fetch(url)
            if Task.isCancelled { return }
            results = items
            isLoading = false
        }
    }

    // MARK: - Category browse (genre / discover / keyword)

    func loadCategory(_ category: SearchCategory) {
        searchTask?.cancel()
        isLoading = true
        results = []

        searchTask = Task {
            let url = Self.url(for: category.title, apiKey: apiKey)
            let items = await fetch(url)
            if Task.isCancelled { return }
            results = items
            isLoading = false
        }
    }

    // MARK: - Networking

    private func fetch(_ url: URL?) async -> [MediaContent] {
        guard let url else { return [] }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(SearchResponse.self, from: data)
            return response.results.compactMap { $0.asMediaContent }
        } catch {
            print("❌ Search error:", error)
            return []
        }
    }

    // MARK: - Map each category title to a TMDB endpoint

    private static func url(for title: String, apiKey: String) -> URL? {
        let base = "https://api.themoviedb.org/3"
        // TMDB genre IDs
        let movieGenre: [String: Int] = [
            "Action": 28, "Adventure": 12, "Comedy": 35, "Drama": 18,
            "Horror": 27, "Romance": 10749, "Sci-Fi": 878, "Thriller": 53,
            "Fantasy": 14, "Animation": 16, "Documentary": 99, "Western": 37,
            "Music": 10402, "Kids & Family": 10751
        ]

        func discover(genre: Int) -> String {
            "\(base)/discover/movie?api_key=\(apiKey)&with_genres=\(genre)&sort_by=popularity.desc&include_adult=false"
        }

        switch title {
        case "Apple TV+":
            // Apple TV+ originals → provider 350
            return URL(string: "\(base)/discover/tv?api_key=\(apiKey)&with_watch_providers=350&watch_region=US&sort_by=popularity.desc")
        case "Season Pass":
            return URL(string: "\(base)/tv/popular?api_key=\(apiKey)")
        case "Bollywood":
            return URL(string: "\(base)/discover/movie?api_key=\(apiKey)&with_original_language=hi&sort_by=popularity.desc")
        case "Regional Indian":
            return URL(string: "\(base)/discover/movie?api_key=\(apiKey)&with_original_language=te|ta|ml|kn&sort_by=popularity.desc")
        case "Classics":
            return URL(string: "\(base)/discover/movie?api_key=\(apiKey)&sort_by=vote_average.desc&vote_count.gte=2000&primary_release_date.lte=2000-12-31")
        case "Independent":
            return URL(string: "\(base)/discover/movie?api_key=\(apiKey)&with_companies=&sort_by=vote_average.desc&vote_count.gte=300&with_genres=18")
        case "Short Films":
            return URL(string: "\(base)/discover/movie?api_key=\(apiKey)&with_genres=10770&sort_by=popularity.desc")
        default:
            if let g = movieGenre[title] {
                return URL(string: discover(genre: g))
            }
            // fallback: treat the title as a text query
            let enc = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
            return URL(string: "\(base)/search/movie?api_key=\(apiKey)&query=\(enc)")
        }
    }
}

// MARK: - Decoding (multi-search returns mixed movie/tv/person)

private struct SearchResponse: Decodable {
    let results: [SearchItem]
}

private struct SearchItem: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let releaseDate: String?
    let firstAirDate: String?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case id, title, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case mediaType = "media_type"
    }

    /// Converts to MediaContent, dropping people and anything without a poster.
    var asMediaContent: MediaContent? {
        // multi-search includes people — skip them
        if mediaType == "person" { return nil }
        guard posterPath != nil || backdropPath != nil else { return nil }

        // Decide movie vs tv: explicit media_type wins, else title vs name.
        let type = mediaType ?? (name != nil && title == nil ? "tv" : "movie")

        return MediaContent(
            id: id,
            title: title,
            name: name,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate ?? firstAirDate,
            youtubeTrailerURL: nil,
            trailerKey: nil,
            mediaType: type
        )
    }
}
