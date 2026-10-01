//
//  DetailCore.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//


//
//  Everything the detail screens need, in ONE file so it can't get half-added
//  to the target: TMDB models, the async service, shared UI components, and the
//  Movie + TV Show detail views.
//

import SwiftUI
import Foundation
import WebKit
import AVFoundation

// ======================================================================
// MARK: FROM TMDBDetailModels.swift
// ======================================================================
struct TMDBGenre: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct TMDBProductionCountry: Decodable, Hashable {
    let iso31661: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct TMDBSpokenLanguage: Decodable, Hashable {
    let iso6391: String?
    let englishName: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case englishName = "english_name"
        case name
    }

    var displayName: String? {
        let n = englishName?.trimmingCharacters(in: .whitespaces)
        if let n, !n.isEmpty { return n }
        let m = name?.trimmingCharacters(in: .whitespaces)
        return (m?.isEmpty == false) ? m : nil
    }
}

struct TMDBCompany: Decodable, Hashable {
    let id: Int
    let name: String
}

struct TMDBNetwork: Decodable, Hashable {
    let id: Int
    let name: String
}

struct TMDBCreator: Decodable, Hashable {
    let id: Int
    let name: String
}

// MARK: - Movie details  (GET /movie/{id})

struct TMDBMovieDetailsResponse: Decodable {
    let id: Int
    let title: String?
    let tagline: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let status: String?
    let originalLanguage: String?
    let genres: [TMDBGenre]?
    let productionCountries: [TMDBProductionCountry]?
    let productionCompanies: [TMDBCompany]?
    let spokenLanguages: [TMDBSpokenLanguage]?

    enum CodingKeys: String, CodingKey {
        case id, title, tagline, overview, runtime, status, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case productionCountries = "production_countries"
        case productionCompanies = "production_companies"
        case spokenLanguages = "spoken_languages"
    }
}

// MARK: - TV details  (GET /tv/{id})

struct TMDBSeasonSummary: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String?
    let seasonNumber: Int
    let episodeCount: Int?
    let posterPath: String?
    let airDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case seasonNumber = "season_number"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case airDate = "air_date"
    }
}

struct TMDBTVDetailsResponse: Decodable {
    let id: Int
    let name: String?
    let tagline: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let episodeRunTime: [Int]?
    let voteAverage: Double?
    let status: String?
    let originalLanguage: String?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let genres: [TMDBGenre]?
    let originCountry: [String]?
    let productionCountries: [TMDBProductionCountry]?
    let spokenLanguages: [TMDBSpokenLanguage]?
    let networks: [TMDBNetwork]?
    let createdBy: [TMDBCreator]?
    let seasons: [TMDBSeasonSummary]?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, overview, status, genres, networks, seasons
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case episodeRunTime = "episode_run_time"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case originCountry = "origin_country"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
        case createdBy = "created_by"
    }
}

// MARK: - Season / episodes  (GET /tv/{id}/season/{n})

struct TMDBEpisode: Decodable, Identifiable, Hashable {
    let id: Int
    let episodeNumber: Int
    let name: String?
    let overview: String?
    let runtime: Int?
    let stillPath: String?
    let airDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, runtime
        case episodeNumber = "episode_number"
        case stillPath = "still_path"
        case airDate = "air_date"
    }
}

struct TMDBSeasonDetailsResponse: Decodable {
    let id: Int?
    let name: String?
    let seasonNumber: Int?
    let episodes: [TMDBEpisode]?

    enum CodingKeys: String, CodingKey {
        case id, name, episodes
        case seasonNumber = "season_number"
    }
}

// MARK: - Videos  (GET /movie|tv/{id}/videos)

struct TMDBVideoItem: Decodable, Identifiable, Hashable {
    let id: String
    let key: String
    let name: String?
    let site: String?
    let type: String?
    let official: Bool?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, key, name, site, type, official
        case publishedAt = "published_at"
    }

    var isYouTube: Bool { site == "YouTube" }

    var thumbnailURL: URL? {
        URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
}

struct TMDBVideoItemsResponse: Decodable {
    let results: [TMDBVideoItem]?
}

// MARK: - Credits  (GET /movie|tv/{id}/credits)

struct CastMember: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let character: String?
    let profilePath: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, character, order
        case profilePath = "profile_path"
    }
}

struct CrewMember: Decodable, Identifiable, Hashable {
    /// TMDB lists the same person once per job, so `id` alone is not unique.
    var id: String { "\(personID)-\(job ?? "")" }
    let personID: Int
    let name: String
    let job: String?
    let department: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case personID = "id"
        case name, job, department
        case profilePath = "profile_path"
    }
}

struct TMDBCreditsResponse: Decodable {
    let cast: [CastMember]?
    let crew: [CrewMember]?
}

// MARK: - Watch providers  (GET /movie|tv/{id}/watch/providers)

struct WatchProvider: Decodable, Identifiable, Hashable {
    let providerID: Int
    let providerName: String
    let logoPath: String?
    let displayPriority: Int?

    var id: Int { providerID }

    enum CodingKeys: String, CodingKey {
        case providerID = "provider_id"
        case providerName = "provider_name"
        case logoPath = "logo_path"
        case displayPriority = "display_priority"
    }
}

struct TMDBWatchRegion: Decodable {
    let link: String?
    let flatrate: [WatchProvider]?
    let rent: [WatchProvider]?
    let buy: [WatchProvider]?
    let free: [WatchProvider]?
    let ads: [WatchProvider]?
}

struct TMDBWatchProvidersResponse: Decodable {
    let results: [String: TMDBWatchRegion]?
}

/// What the UI actually needs: one region, already picked.
struct WatchProviderGroup: Identifiable {
    let title: String            // "Stream", "Rent", "Buy", "Free"
    let providers: [WatchProvider]
    var id: String { title }
}

struct WatchProviderInfo {
    let regionCode: String
    let link: URL?
    let groups: [WatchProviderGroup]
}

// MARK: - Certifications

struct TMDBReleaseDatesResponse: Decodable {
    struct Country: Decodable {
        struct Release: Decodable { let certification: String? }
        let iso31661: String?
        let releaseDates: [Release]?
        enum CodingKeys: String, CodingKey {
            case iso31661 = "iso_3166_1"
            case releaseDates = "release_dates"
        }
    }
    let results: [Country]?
}

struct TMDBContentRatingsResponse: Decodable {
    struct Entry: Decodable {
        let iso31661: String?
        let rating: String?
        enum CodingKeys: String, CodingKey {
            case iso31661 = "iso_3166_1"
            case rating
        }
    }
    let results: [Entry]?
}

// MARK: - View-facing detail models
// These are what the view models publish, so the views never touch raw
// TMDB optionals and the "is this field missing?" logic lives in one place.

struct MovieDetail {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let genres: [String]
    let originalLanguageCode: String?
    let spokenLanguages: [String]
    let countries: [String]
    let studios: [String]
    let status: String?

    init(_ r: TMDBMovieDetailsResponse) {
        id = r.id
        title = r.title ?? ""
        tagline = r.tagline.nonEmpty
        overview = r.overview.nonEmpty
        posterPath = r.posterPath
        backdropPath = r.backdropPath
        releaseDate = r.releaseDate.nonEmpty
        runtime = (r.runtime ?? 0) > 0 ? r.runtime : nil
        voteAverage = (r.voteAverage ?? 0) > 0 ? r.voteAverage : nil
        genres = (r.genres ?? []).map(\.name)
        originalLanguageCode = r.originalLanguage.nonEmpty
        spokenLanguages = (r.spokenLanguages ?? []).compactMap(\.displayName)
        countries = (r.productionCountries ?? []).compactMap(\.name)
        studios = (r.productionCompanies ?? []).map(\.name)
        status = r.status.nonEmpty
    }
}

struct TVShowDetail {
    let id: Int
    let name: String
    let tagline: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let runtime: Int?
    let voteAverage: Double?
    let genres: [String]
    let originalLanguageCode: String?
    let spokenLanguages: [String]
    let countries: [String]
    let networks: [String]
    let creators: [String]
    let seasons: [TMDBSeasonSummary]
    let numberOfEpisodes: Int?
    let status: String?

    init(_ r: TMDBTVDetailsResponse) {
        id = r.id
        name = r.name ?? ""
        tagline = r.tagline.nonEmpty
        overview = r.overview.nonEmpty
        posterPath = r.posterPath
        backdropPath = r.backdropPath
        firstAirDate = r.firstAirDate.nonEmpty
        runtime = r.episodeRunTime?.first(where: { $0 > 0 })
        voteAverage = (r.voteAverage ?? 0) > 0 ? r.voteAverage : nil
        genres = (r.genres ?? []).map(\.name)
        originalLanguageCode = r.originalLanguage.nonEmpty
        spokenLanguages = (r.spokenLanguages ?? []).compactMap(\.displayName)

        let named = (r.productionCountries ?? []).compactMap(\.name)
        if !named.isEmpty {
            countries = named
        } else {
            countries = (r.originCountry ?? []).compactMap {
                Locale.current.localizedString(forRegionCode: $0)
            }
        }

        networks = (r.networks ?? []).map(\.name)
        creators = (r.createdBy ?? []).map(\.name)
        numberOfEpisodes = r.numberOfEpisodes
        status = r.status.nonEmpty

        // Season 0 is "Specials". Keep regular seasons first, specials last.
        let all = r.seasons ?? []
        let regular = all.filter { $0.seasonNumber > 0 }.sorted { $0.seasonNumber < $1.seasonNumber }
        let specials = all.filter { $0.seasonNumber == 0 && ($0.episodeCount ?? 0) > 0 }
        seasons = regular + specials
    }
}

// MARK: - Helpers

extension Optional where Wrapped == String {
    /// nil for nil, "" and whitespace-only strings.
    var nonEmpty: String? {
        guard let s = self?.trimmingCharacters(in: .whitespacesAndNewlines), !s.isEmpty else { return nil }
        return s
    }
}

// ======================================================================
// MARK: FROM TMDBDetailService.swift
// ======================================================================
enum TMDBMediaKind {
    case movie, tv

    var path: String { self == .movie ? "movie" : "tv" }
    var shareURLPrefix: String { "https://www.themoviedb.org/\(path)/" }
}

enum TMDBDetailService {

    private static let base = "https://api.themoviedb.org/3"

    // MARK: - Core request

    static func fetch<T: Decodable>(
        _ path: String,
        query: [String: String] = [:],
        as type: T.Type = T.self
    ) async throws -> T {
        guard var comps = URLComponents(string: base + path) else {
            throw URLError(.badURL)
        }
        var items = [
            URLQueryItem(name: "api_key", value: TMDBConfig.apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ]
        items += query.map { URLQueryItem(name: $0.key, value: $0.value) }
        comps.queryItems = items

        guard let url = comps.url else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    // MARK: - Details (these two are REQUIRED; callers show an error state if they throw)

    static func movieDetails(id: Int) async throws -> MovieDetail {
        MovieDetail(try await fetch("/movie/\(id)", as: TMDBMovieDetailsResponse.self))
    }

    static func tvDetails(id: Int) async throws -> TVShowDetail {
        TVShowDetail(try await fetch("/tv/\(id)", as: TMDBTVDetailsResponse.self))
    }

    // MARK: - Optional extras (never throw)

    static func videos(kind: TMDBMediaKind, id: Int) async -> [TMDBVideoItem] {
        let response = try? await fetch(
            "/\(kind.path)/\(id)/videos",
            query: ["include_video_language": "en,null"],
            as: TMDBVideoItemsResponse.self
        )
        return (response?.results ?? []).filter { $0.isYouTube && !$0.key.isEmpty }
    }

    static func credits(kind: TMDBMediaKind, id: Int) async -> TMDBCreditsResponse? {
        try? await fetch("/\(kind.path)/\(id)/credits", as: TMDBCreditsResponse.self)
    }

    /// Recommendations first; falls back to "similar" if TMDB has none.
    static func related(kind: TMDBMediaKind, id: Int) async -> [MediaContent] {
        let tag = kind.path
        let recs = (try? await fetch("/\(kind.path)/\(id)/recommendations", as: TMDBResponse.self))?.results ?? []
        var list = recs.filter { $0.posterPath != nil }
        if list.isEmpty {
            let similar = (try? await fetch("/\(kind.path)/\(id)/similar", as: TMDBResponse.self))?.results ?? []
            list = similar.filter { $0.posterPath != nil }
        }
        return list.map { $0.withMediaType(tag) }
    }

    static func watchProviders(kind: TMDBMediaKind, id: Int) async -> WatchProviderInfo? {
        guard let response = try? await fetch(
            "/\(kind.path)/\(id)/watch/providers",
            as: TMDBWatchProvidersResponse.self
        ), let results = response.results else { return nil }

        for code in preferredRegionCodes {
            guard let region = results[code] else { continue }

            func sorted(_ p: [WatchProvider]?) -> [WatchProvider] {
                (p ?? []).sorted { ($0.displayPriority ?? 999) < ($1.displayPriority ?? 999) }
            }

            let groups = [
                WatchProviderGroup(title: "Stream", providers: sorted(region.flatrate)),
                WatchProviderGroup(title: "Free", providers: sorted((region.free ?? []) + (region.ads ?? []))),
                WatchProviderGroup(title: "Rent", providers: sorted(region.rent)),
                WatchProviderGroup(title: "Buy", providers: sorted(region.buy))
            ].filter { !$0.providers.isEmpty }

            if !groups.isEmpty {
                return WatchProviderInfo(
                    regionCode: code,
                    link: region.link.flatMap(URL.init(string:)),
                    groups: groups
                )
            }
        }
        return nil
    }

    /// Age rating, e.g. "PG-13" / "TV-MA". nil when TMDB has none.
    static func certification(kind: TMDBMediaKind, id: Int) async -> String? {
        switch kind {
        case .movie:
            guard let r = try? await fetch("/movie/\(id)/release_dates", as: TMDBReleaseDatesResponse.self),
                  let countries = r.results else { return nil }
            for code in preferredRegionCodes {
                let cert = countries
                    .first { $0.iso31661 == code }?
                    .releaseDates?
                    .compactMap { $0.certification.nonEmpty }
                    .first
                if let cert { return cert }
            }
            return nil

        case .tv:
            guard let r = try? await fetch("/tv/\(id)/content_ratings", as: TMDBContentRatingsResponse.self),
                  let entries = r.results else { return nil }
            for code in preferredRegionCodes {
                if let rating = entries.first(where: { $0.iso31661 == code })?.rating.nonEmpty {
                    return rating
                }
            }
            return nil
        }
    }

    static func episodes(tvID: Int, season: Int) async throws -> [TMDBEpisode] {
        let r = try await fetch("/tv/\(tvID)/season/\(season)", as: TMDBSeasonDetailsResponse.self)
        return (r.episodes ?? []).sorted { $0.episodeNumber < $1.episodeNumber }
    }

    // MARK: - Helpers

    /// User's region first, then US as a sensible fallback.
    private static var preferredRegionCodes: [String] {
        var codes: [String] = []
        if let region = Locale.current.region?.identifier { codes.append(region) }
        if !codes.contains("US") { codes.append("US") }
        return codes
    }

    // MARK: - Trailer selection

    /// Hero/Play trailer: official Trailer > any Trailer > Teaser > Clip.
    static func bestTrailer(from videos: [TMDBVideoItem]) -> TMDBVideoItem? {
        let trailers = videos.filter { $0.type == "Trailer" }
        return trailers.first(where: { $0.official == true })
            ?? trailers.first
            ?? videos.first(where: { $0.type == "Teaser" })
            ?? videos.first(where: { $0.type == "Clip" })
    }
}

// MARK: - Everything-except-core-details, loaded in parallel

struct MediaExtras {
    var videos: [TMDBVideoItem] = []
    var cast: [CastMember] = []
    var crew: [CrewMember] = []
    var related: [MediaContent] = []
    var providers: WatchProviderInfo?
    var certification: String?

    static func load(kind: TMDBMediaKind, id: Int) async -> MediaExtras {
        async let videos = TMDBDetailService.videos(kind: kind, id: id)
        async let credits = TMDBDetailService.credits(kind: kind, id: id)
        async let related = TMDBDetailService.related(kind: kind, id: id)
        async let providers = TMDBDetailService.watchProviders(kind: kind, id: id)
        async let certification = TMDBDetailService.certification(kind: kind, id: id)

        let c = await credits
        return MediaExtras(
            videos: await videos,
            cast: c?.cast ?? [],
            crew: c?.crew ?? [],
            related: await related,
            providers: await providers,
            certification: await certification
        )
    }

    // MARK: Derived

    var bestTrailer: TMDBVideoItem? { TMDBDetailService.bestTrailer(from: videos) }

    /// "Trailers" row: trailers + teasers.
    var trailers: [TMDBVideoItem] {
        videos.filter { $0.type == "Trailer" || $0.type == "Teaser" }
    }

    /// "Bonus Content" row: featurettes, behind the scenes, clips, bloopers...
    var bonus: [TMDBVideoItem] {
        videos.filter { $0.type != "Trailer" && $0.type != "Teaser" }
    }

    var topCast: [CastMember] {
        Array(cast.sorted { ($0.order ?? 999) < ($1.order ?? 999) }.prefix(20))
    }

    /// Director / writers / producers etc., one entry per person+job.
    var keyCrew: [CrewMember] {
        let priority = ["Director", "Creator", "Writer", "Screenplay", "Executive Producer",
                        "Producer", "Original Music Composer", "Director of Photography"]
        var seen = Set<String>()
        var result: [CrewMember] = []
        for job in priority {
            for member in crew where member.job == job && seen.insert(member.id).inserted {
                result.append(member)
            }
        }
        return Array(result.prefix(10))
    }
}

// ======================================================================
// MARK: FROM DetailComponents.swift
// ======================================================================
enum TMDBImage {
    static func url(_ path: String?, size: String) -> URL? {
        guard let path, !path.isEmpty else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(path)")
    }
}

enum DetailFormat {
    static func year(_ date: String?) -> String? {
        guard let date, date.count >= 4 else { return nil }
        let y = String(date.prefix(4))
        return Int(y) == nil ? nil : y
    }

    static func runtime(_ minutes: Int?) -> String? {
        guard let m = minutes, m > 0 else { return nil }
        let h = m / 60, r = m % 60
        if h == 0 { return "\(r)m" }
        if r == 0 { return "\(h)h" }
        return "\(h)h \(r)m"
    }

    static func longDate(_ date: String?) -> String? {
        guard let date, !date.isEmpty else { return nil }
        let parser = DateFormatter()
        parser.locale = Locale(identifier: "en_US_POSIX")
        parser.dateFormat = "yyyy-MM-dd"
        guard let d = parser.date(from: date) else { return nil }
        let out = DateFormatter()
        out.dateStyle = .long
        return out.string(from: d)
    }

    /// "English" from "en", using the device locale.
    static func languageName(code: String?) -> String? {
        guard let code, !code.isEmpty else { return nil }
        return Locale.current.localizedString(forLanguageCode: code)
    }
}

/// A trailer the user asked to play full screen.
struct PlayableVideo: Identifiable {
    let key: String
    let title: String
    var id: String { key }
}

// MARK: - Glass controls

struct GlassCircleIcon: View {
    let systemName: String
    var size: CGFloat = 40

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: size * 0.4, weight: .semibold))
            .foregroundColor(.white)
            .frame(width: size, height: size)
            .background(.ultraThinMaterial, in: Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.18), lineWidth: 1))
            .contentShape(Circle())
    }
}

/// Fixed back + share buttons that float above the scrolling page.
struct DetailChrome: ViewModifier {
    let shareURL: URL?
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                HStack {
                    Button { dismiss() } label: {
                        GlassCircleIcon(systemName: "chevron.left")
                    }
                    Spacer()
                    if let shareURL {
                        ShareLink(item: shareURL) {
                            GlassCircleIcon(systemName: "square.and.arrow.up")
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
    }
}

extension View {
    func detailChrome(shareURL: URL?) -> some View {
        modifier(DetailChrome(shareURL: shareURL))
    }
}

// MARK: - Hero

struct DetailHero: View {
    let title: String
    let genresLine: String?
    let metaParts: [String]
    let certification: String?
    let score: Double?
    let overview: String?
    let backdropURL: URL?
    let trailerKey: String?
    let playTitle: String
    let canPlay: Bool
    let onPlay: () -> Void
    @Binding var isAdded: Bool
    /// True while the full-screen trailer is up, so the hero video stops.
    var isVideoSuspended: Bool = false

    @State private var videoPlaying = false
    @State private var isMuted = true
    @State private var heroAppeared = false

    private var heroHeight: CGFloat { min(640, UIScreen.main.bounds.height * 0.70) }

    var body: some View {
        Color.black
            .frame(maxWidth: .infinity)
            .frame(height: heroHeight)
            .overlay { backdrop }
            .overlay { inlineVideo }
            .overlay { gradient }
            .overlay(alignment: .bottom) { info }
            .overlay(alignment: .bottomTrailing) { muteButton }
            .clipped()
            .onAppear { heroAppeared = true }
            .onDisappear {
                heroAppeared = false
                videoPlaying = false
            }
    }

    // MARK: Layers

    private var backdrop: some View {
        AsyncImage(url: backdropURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            default:
                Color(white: 0.12)
            }
        }
    }

    @ViewBuilder
    private var inlineVideo: some View {
        if let key = trailerKey, heroAppeared, !isVideoSuspended {
            // The embed is 16:9; render it at hero height and let the hero crop the sides.
            HeroTrailerWebView(
                videoKey: key,
                isMuted: isMuted,
                onPlaying: { withAnimation(.easeIn(duration: 0.8)) { videoPlaying = true } }
            )
            .frame(width: heroHeight * 16 / 9, height: heroHeight)
            .allowsHitTesting(false)
            .opacity(videoPlaying ? 1 : 0)
        }
    }

    private var gradient: some View {
        LinearGradient(
            stops: [
                .init(color: .black.opacity(0.35), location: 0.0),
                .init(color: .clear, location: 0.18),
                .init(color: .black.opacity(0.55), location: 0.55),
                .init(color: .black, location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .allowsHitTesting(false)
    }

    private var info: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.7)
                .shadow(color: .black.opacity(0.5), radius: 10)

            if let genresLine {
                Text(genresLine)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }

            metaRow

            if let overview {
                Text(overview)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.horizontal, 12)
            }

            HStack(spacing: 14) {
                if canPlay {
                    Button(action: onPlay) {
                        HStack(spacing: 8) {
                            Image(systemName: "play.fill")
                            Text(playTitle)
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .frame(height: 50)
                        .background(Color.white, in: Capsule())
                    }
                }

                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) { isAdded.toggle() }
                } label: {
                    GlassCircleIcon(systemName: isAdded ? "checkmark" : "plus", size: 50)
                        .scaleEffect(isAdded ? 1.05 : 1.0)
                }
            }
            .padding(.top, 6)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
    }

    @ViewBuilder
    private var metaRow: some View {
        let parts = metaParts
        if !parts.isEmpty || certification != nil || score != nil {
            HStack(spacing: 8) {
                ForEach(Array(parts.enumerated()), id: \.offset) { _, part in
                    Text(part)
                }
                if let score {
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill").font(.system(size: 10))
                        Text(String(format: "%.1f", score))
                    }
                }
                if let certification {
                    Text(certification)
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.white.opacity(0.6), lineWidth: 1))
                }
            }
            .font(.footnote.weight(.medium))
            .foregroundColor(.white.opacity(0.75))
        }
    }

    /// Only shown once the video is really playing.
    @ViewBuilder
    private var muteButton: some View {
        if videoPlaying {
            Button { isMuted.toggle() } label: {
                GlassCircleIcon(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill", size: 34)
            }
            .padding(.trailing, 16)
            .padding(.bottom, 8)
            .transition(.opacity)
        }
    }
}

// MARK: - Inline hero trailer (muted autoplay, silently falls back to the backdrop)

struct HeroTrailerWebView: UIViewRepresentable {
    let videoKey: String
    let isMuted: Bool
    let onPlaying: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onPlaying: onPlaying)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let web = WKWebView(frame: .zero, configuration: config)
        web.isOpaque = false
        web.backgroundColor = .black
        web.scrollView.backgroundColor = .black
        web.scrollView.isScrollEnabled = false
        web.isUserInteractionEnabled = false

        let html = """
        <!DOCTYPE html>
        <html>
        <head><meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
        <style>html,body{margin:0;padding:0;width:100%;height:100%;background:black;overflow:hidden;}
        iframe{width:100vw;height:100vh;border:none;}</style></head>
        <body>
        <iframe
            src="https://www.youtube-nocookie.com/embed/\(videoKey)?autoplay=1&mute=1&controls=0&loop=1&playlist=\(videoKey)&playsinline=1&rel=0&modestbranding=1&iv_load_policy=3&disablekb=1&fs=0"
            allow="autoplay; encrypted-media; picture-in-picture"
            allowfullscreen>
        </iframe>
        </body>
        </html>
        """
        web.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
        context.coordinator.startPolling(web)
        return web
    }

    func updateUIView(_ web: WKWebView, context: Context) {
        context.coordinator.setMuted(isMuted, on: web)
    }

    static func dismantleUIView(_ web: WKWebView, coordinator: Coordinator) {
        coordinator.stop()
        web.stopLoading()
        web.loadHTMLString("", baseURL: nil)   // kills audio/video immediately
    }

    final class Coordinator {
        private let onPlaying: () -> Void
        private var timer: Timer?
        private var attempts = 0
        private var muted = true

        init(onPlaying: @escaping () -> Void) {
            self.onPlaying = onPlaying
        }

        /// Reveal the video only once a <video> element is genuinely playing.
        /// If YouTube refuses the embed or autoplay is blocked, this never fires and
        /// the user keeps seeing the backdrop image.
        func startPolling(_ web: WKWebView) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { [weak self, weak web] t in
                guard let self, let web else { t.invalidate(); return }
                self.attempts += 1
                if self.attempts > 25 { t.invalidate(); return }

                let js = "(function(){var v=document.querySelector('video');return !!v && !v.paused && v.currentTime>0.4;})()"
                web.evaluateJavaScript(js) { result, _ in
                    if (result as? Bool) == true {
                        t.invalidate()
                        DispatchQueue.main.async { self.onPlaying() }
                    }
                }
            }
        }

        func setMuted(_ newValue: Bool, on web: WKWebView) {
            guard newValue != muted else { return }
            muted = newValue
            web.evaluateJavaScript("var v=document.querySelector('video'); if(v){v.muted=\(newValue);}")
        }

        func stop() {
            timer?.invalidate()
            timer = nil
        }
    }
}

// MARK: - Section scaffolding

struct DetailSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            content()
        }
    }
}

// MARK: - Trailers / Bonus content

struct VideoCardsRow: View {
    let videos: [TMDBVideoItem]
    let onSelect: (TMDBVideoItem) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(videos) { video in
                    Button { onSelect(video) } label: { card(video) }
                        .buttonStyle(CardPressStyle())
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private func card(_ video: TMDBVideoItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Color(white: 0.14)
                .frame(width: 260, height: 146)
                .overlay {
                    AsyncImage(url: video.thumbnailURL) { phase in
                        if case .success(let image) = phase {
                            image.resizable().scaledToFill()
                        }
                    }
                }
                .overlay {
                    GlassCircleIcon(systemName: "play.fill", size: 44)
                }
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.1), lineWidth: 1))

            Text(video.name ?? video.type ?? "Video")
                .font(.subheadline.weight(.medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 260, alignment: .leading)

            if let type = video.type {
                Text(type)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.55))
            }
        }
    }
}

// MARK: - Related

struct RelatedRow: View {
    let items: [MediaContent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 14) {
                ForEach(items) { item in
                    MediaDetailLink(content: item) {
                        VStack(alignment: .leading, spacing: 8) {
                            Color(white: 0.14)
                                .frame(width: 120, height: 180)
                                .overlay {
                                    AsyncImage(url: TMDBImage.url(item.posterPath, size: "w342")) { phase in
                                        if case .success(let image) = phase {
                                            image.resizable().scaledToFill()
                                        }
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.1), lineWidth: 1))

                            Text(item.title ?? item.name ?? "")
                                .font(.footnote.weight(.medium))
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .frame(width: 120, alignment: .leading)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Cast & crew

struct PersonItem: Identifiable {
    let id: String
    let name: String
    let subtitle: String?
    let profilePath: String?
}

struct CastCrewRow: View {
    let people: [PersonItem]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(people) { person in
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color(white: 0.16))
                            .frame(width: 88, height: 88)
                            .overlay {
                                if let url = TMDBImage.url(person.profilePath, size: "w185") {
                                    AsyncImage(url: url) { phase in
                                        if case .success(let image) = phase {
                                            image.resizable().scaledToFill()
                                        } else {
                                            placeholder
                                        }
                                    }
                                } else {
                                    placeholder
                                }
                            }
                            .clipShape(Circle())

                        Text(person.name)
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)

                        if let subtitle = person.subtitle {
                            Text(subtitle)
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.55))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(width: 96)
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private var placeholder: some View {
        Image(systemName: "person.fill")
            .font(.system(size: 30))
            .foregroundColor(.white.opacity(0.3))
    }
}

extension MediaExtras {
    /// Cast first, then key crew, as one row.
    var people: [PersonItem] {
        let castItems = topCast.map {
            PersonItem(id: "cast-\($0.id)", name: $0.name, subtitle: $0.character.nonEmpty, profilePath: $0.profilePath)
        }
        let crewItems = keyCrew.map {
            PersonItem(id: "crew-\($0.id)", name: $0.name, subtitle: $0.job, profilePath: $0.profilePath)
        }
        return castItems + crewItems
    }
}

// MARK: - How to Watch

struct WatchProvidersSection: View {
    let info: WatchProviderInfo
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(info.groups) { group in
                VStack(alignment: .leading, spacing: 8) {
                    Text(group.title)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.white.opacity(0.6))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(group.providers) { provider in
                                VStack(spacing: 6) {
                                    Color(white: 0.16)
                                        .frame(width: 56, height: 56)
                                        .overlay {
                                            AsyncImage(url: TMDBImage.url(provider.logoPath, size: "w92")) { phase in
                                                if case .success(let image) = phase {
                                                    image.resizable().scaledToFill()
                                                }
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 13))

                                    Text(provider.providerName)
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.7))
                                        .lineLimit(1)
                                        .frame(width: 64)
                                }
                            }
                        }
                    }
                }
            }

            Text("Availability in \(regionName) · Data by JustWatch")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .onTapGesture {
            if let link = info.link { openURL(link) }
        }
    }

    private var regionName: String {
        Locale.current.localizedString(forRegionCode: info.regionCode) ?? info.regionCode
    }
}

// MARK: - About / Information / Languages

struct AboutSection: View {
    let title: String
    let genres: [String]
    let overview: String?
    let tagline: String?

    var body: some View {
        DetailSection(title: "About") {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                if !genres.isEmpty {
                    Text(genres.joined(separator: " · "))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.55))
                }
                if let tagline {
                    Text(tagline)
                        .font(.subheadline.italic())
                        .foregroundColor(.white.opacity(0.7))
                }
                if let overview {
                    Text(overview)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct InfoItem: Identifiable {
    let label: String
    let value: String
    var id: String { label }
}

/// Used for both "Information" and "Languages". Callers pass only rows that have real values.
struct InfoGridSection: View {
    let title: String
    let items: [InfoItem]

    var body: some View {
        DetailSection(title: title) {
            LazyVGrid(
                columns: [GridItem(.flexible(), alignment: .topLeading),
                          GridItem(.flexible(), alignment: .topLeading)],
                alignment: .leading,
                spacing: 18
            ) {
                ForEach(items) { item in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(item.label)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                        Text(item.value)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Loading / error

struct DetailLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .frame(maxWidth: .infinity, minHeight: 200)
    }
}

struct DetailErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 36))
                .foregroundColor(.white.opacity(0.6))
            Text(message)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            Button(action: retry) {
                Text("Try Again")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 22)
                    .frame(height: 44)
                    .background(Color.white, in: Capsule())
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, minHeight: 300)
    }
}

// ======================================================================
// MARK: FROM MovieDetailView.swift
// ======================================================================
struct MovieDetailView: View {
    let content: MediaContent

    @StateObject private var viewModel: MovieDetailViewModel
    @State private var isAdded = false
    @State private var playingVideo: PlayableVideo?

    init(content: MediaContent) {
        self.content = content
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieID: content.id))
    }

    private var shareURL: URL? {
        URL(string: "\(TMDBMediaKind.movie.shareURLPrefix)\(content.id)")
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let message = viewModel.errorMessage {
                DetailErrorView(message: message) { Task { await viewModel.retry() } }
            } else if let detail = viewModel.detail {
                detailBody(for: detail)
            } else {
                DetailLoadingView()
            }
        }
        .detailChrome(shareURL: shareURL)
        .task { await viewModel.load() }
        .fullScreenCover(item: $playingVideo) { video in
            FullScreenTrailerView(videoKey: video.key, title: video.title)
        }
    }

    // MARK: - Content

    private func detailBody(for detail: MovieDetail) -> some View {
        let extras = viewModel.extras
        let trailer = extras.bestTrailer

        return ScrollView {
            VStack(alignment: .leading, spacing: 34) {

                DetailHero(
                    title: detail.title,
                    genresLine: detail.genres.isEmpty ? nil : detail.genres.prefix(3).joined(separator: "  ·  "),
                    metaParts: heroMeta(detail),
                    certification: extras.certification,
                    score: detail.voteAverage,
                    overview: detail.overview,
                    backdropURL: TMDBImage.url(detail.backdropPath ?? detail.posterPath, size: "w1280"),
                    trailerKey: trailer?.key,
                    playTitle: "Play",
                    canPlay: trailer != nil,
                    onPlay: {
                        if let trailer {
                            playingVideo = PlayableVideo(key: trailer.key, title: detail.title)
                        }
                    },
                    isAdded: $isAdded,
                    isVideoSuspended: playingVideo != nil
                )

                if !extras.trailers.isEmpty {
                    DetailSection(title: "Trailers") {
                        VideoCardsRow(videos: extras.trailers) { play($0, title: detail.title) }
                    }
                }

                if !extras.bonus.isEmpty {
                    DetailSection(title: "Bonus Content") {
                        VideoCardsRow(videos: extras.bonus) { play($0, title: detail.title) }
                    }
                }

                if !extras.related.isEmpty {
                    DetailSection(title: "You May Also Like") {
                        RelatedRow(items: extras.related)
                    }
                }

                if !extras.people.isEmpty {
                    DetailSection(title: "Cast & Crew") {
                        CastCrewRow(people: extras.people)
                    }
                }

                if let providers = extras.providers {
                    DetailSection(title: "How to Watch") {
                        WatchProvidersSection(info: providers)
                    }
                }

                if !detail.genres.isEmpty || detail.overview != nil {
                    AboutSection(
                        title: detail.title,
                        genres: detail.genres,
                        overview: detail.overview,
                        tagline: detail.tagline
                    )
                }

                let info = informationItems(detail, certification: extras.certification)
                if !info.isEmpty {
                    InfoGridSection(title: "Information", items: info)
                }

                let languages = languageItems(detail)
                if !languages.isEmpty {
                    InfoGridSection(title: "Languages", items: languages)
                }

                InfoGridSection(title: "Accessibility", items: accessibilityItems())

                Color.clear.frame(height: 40)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
    }

    private func play(_ video: TMDBVideoItem, title: String) {
        playingVideo = PlayableVideo(key: video.key, title: video.name ?? title)
    }

    // MARK: - Field builders (only real values)

    private func heroMeta(_ detail: MovieDetail) -> [String] {
        var parts: [String] = []
        if let year = DetailFormat.year(detail.releaseDate) { parts.append(year) }
        if let runtime = DetailFormat.runtime(detail.runtime) { parts.append(runtime) }
        return parts
    }

    private func informationItems(_ detail: MovieDetail, certification: String?) -> [InfoItem] {
        var items: [InfoItem] = []
        if let released = DetailFormat.longDate(detail.releaseDate) {
            items.append(InfoItem(label: "Released", value: released))
        }
        if let certification {
            items.append(InfoItem(label: "Rating", value: certification))
        }
        if let score = detail.voteAverage {
            items.append(InfoItem(label: "Score", value: String(format: "%.1f / 10", score)))
        }
        if !detail.studios.isEmpty {
            items.append(InfoItem(label: "Studio", value: detail.studios.prefix(2).joined(separator: ", ")))
        }
        if !detail.countries.isEmpty {
            items.append(InfoItem(label: "Region of Origin", value: detail.countries.joined(separator: ", ")))
        }
        return items
    }

    private func languageItems(_ detail: MovieDetail) -> [InfoItem] {
        var items: [InfoItem] = []
        if let original = DetailFormat.languageName(code: detail.originalLanguageCode) {
            items.append(InfoItem(label: "Original Audio", value: original))
        }
        if !detail.spokenLanguages.isEmpty {
            items.append(InfoItem(label: "Audio", value: detail.spokenLanguages.prefix(5).joined(separator: ", ")))
        }
        return items
    }

    /// TMDB doesn't expose SDH / audio-description, so we state what we can't confirm
    /// rather than invent a checkmark.
    private func accessibilityItems() -> [InfoItem] {
        [InfoItem(label: "SDH & Audio Description", value: "Varies by provider")]
    }
}

// ======================================================================
// MARK: FROM TVShowDetailView.swift
// ======================================================================
struct TVShowDetailView: View {
    let content: MediaContent

    @StateObject private var viewModel: TVShowDetailViewModel
    @State private var isAdded = false
    @State private var playingVideo: PlayableVideo?

    init(content: MediaContent) {
        self.content = content
        _viewModel = StateObject(wrappedValue: TVShowDetailViewModel(showID: content.id))
    }

    private var shareURL: URL? {
        URL(string: "\(TMDBMediaKind.tv.shareURLPrefix)\(content.id)")
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let message = viewModel.errorMessage {
                DetailErrorView(message: message) { Task { await viewModel.retry() } }
            } else if let detail = viewModel.detail {
                detailBody(for: detail)
            } else {
                DetailLoadingView()
            }
        }
        .detailChrome(shareURL: shareURL)
        .task { await viewModel.load() }
        .fullScreenCover(item: $playingVideo) { video in
            FullScreenTrailerView(videoKey: video.key, title: video.title)
        }
    }

    // MARK: - Content

    private func detailBody(for detail: TVShowDetail) -> some View {
        let extras = viewModel.extras
        let trailer = extras.bestTrailer

        return ScrollView {
            VStack(alignment: .leading, spacing: 34) {

                DetailHero(
                    title: detail.name,
                    genresLine: detail.genres.isEmpty ? nil : detail.genres.prefix(3).joined(separator: "  ·  "),
                    metaParts: heroMeta(detail),
                    certification: extras.certification,
                    score: detail.voteAverage,
                    overview: detail.overview,
                    backdropURL: TMDBImage.url(detail.backdropPath ?? detail.posterPath, size: "w1280"),
                    trailerKey: trailer?.key,
                    playTitle: "Play First Episode",
                    canPlay: trailer != nil,
                    onPlay: {
                        if let trailer {
                            playingVideo = PlayableVideo(key: trailer.key, title: detail.name)
                        }
                    },
                    isAdded: $isAdded,
                    isVideoSuspended: playingVideo != nil
                )

                if !detail.seasons.isEmpty {
                    seasonSection(detail)
                }

                if !extras.trailers.isEmpty {
                    DetailSection(title: "Trailers") {
                        VideoCardsRow(videos: extras.trailers) { play($0, title: detail.name) }
                    }
                }

                if !extras.bonus.isEmpty {
                    DetailSection(title: "Bonus Content") {
                        VideoCardsRow(videos: extras.bonus) { play($0, title: detail.name) }
                    }
                }

                if !extras.related.isEmpty {
                    DetailSection(title: "Related") {
                        RelatedRow(items: extras.related)
                    }
                }

                if !extras.people.isEmpty {
                    DetailSection(title: "Cast & Crew") {
                        CastCrewRow(people: extras.people)
                    }
                }

                if let providers = extras.providers {
                    DetailSection(title: "How to Watch") {
                        WatchProvidersSection(info: providers)
                    }
                }

                if !detail.genres.isEmpty || detail.overview != nil {
                    AboutSection(
                        title: detail.name,
                        genres: detail.genres,
                        overview: detail.overview,
                        tagline: detail.tagline
                    )
                }

                let info = informationItems(detail, certification: extras.certification)
                if !info.isEmpty {
                    InfoGridSection(title: "Information", items: info)
                }

                let languages = languageItems(detail)
                if !languages.isEmpty {
                    InfoGridSection(title: "Languages", items: languages)
                }

                InfoGridSection(title: "Accessibility", items: accessibilityItems())

                Color.clear.frame(height: 40)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
    }

    // MARK: - Seasons & episodes

    private func seasonSection(_ detail: TVShowDetail) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            // Season selector
            HStack {
                Menu {
                    ForEach(detail.seasons) { season in
                        Button {
                            Task { await viewModel.selectSeason(season.seasonNumber) }
                        } label: {
                            if viewModel.selectedSeasonNumber == season.seasonNumber {
                                Label(seasonLabel(season), systemImage: "checkmark")
                            } else {
                                Text(seasonLabel(season))
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text(currentSeasonLabel(detail))
                            .font(.title3.weight(.bold))
                            .foregroundColor(.white)
                        Image(systemName: "chevron.down")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)

            episodeContent
        }
    }

    @ViewBuilder
    private var episodeContent: some View {
        if viewModel.isLoadingEpisodes {
            DetailLoadingView().frame(height: 220)
        } else if viewModel.episodesFailed {
            Text("Couldn't load episodes for this season.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
                .padding(.horizontal, 20)
                .frame(height: 120)
        } else if viewModel.selectedEpisodes.isEmpty {
            Text("No episodes available yet.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
                .padding(.horizontal, 20)
                .frame(height: 120)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 14) {
                    ForEach(viewModel.selectedEpisodes) { episode in
                        EpisodeCard(
                            episode: episode,
                            showBackdropPath: viewModel.detail?.backdropPath
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private func seasonLabel(_ season: TMDBSeasonSummary) -> String {
        if season.seasonNumber == 0 { return season.name ?? "Specials" }
        return "Season \(season.seasonNumber)"
    }

    private func currentSeasonLabel(_ detail: TVShowDetail) -> String {
        guard let n = viewModel.selectedSeasonNumber,
              let season = detail.seasons.first(where: { $0.seasonNumber == n }) else {
            return "Episodes"
        }
        return seasonLabel(season)
    }

    private func play(_ video: TMDBVideoItem, title: String) {
        playingVideo = PlayableVideo(key: video.key, title: video.name ?? title)
    }

    // MARK: - Field builders

    private func heroMeta(_ detail: TVShowDetail) -> [String] {
        var parts: [String] = []
        if let year = DetailFormat.year(detail.firstAirDate) { parts.append(year) }
        if let seasons = viewModel.detail?.seasons.filter({ $0.seasonNumber > 0 }).count, seasons > 0 {
            parts.append(seasons == 1 ? "1 Season" : "\(seasons) Seasons")
        }
        return parts
    }

    private func informationItems(_ detail: TVShowDetail, certification: String?) -> [InfoItem] {
        var items: [InfoItem] = []
        if let released = DetailFormat.longDate(detail.firstAirDate) {
            items.append(InfoItem(label: "Released", value: released))
        }
        if let certification {
            items.append(InfoItem(label: "Rating", value: certification))
        }
        if let score = detail.voteAverage {
            items.append(InfoItem(label: "Score", value: String(format: "%.1f / 10", score)))
        }
        if let episodes = detail.numberOfEpisodes, episodes > 0 {
            items.append(InfoItem(label: "Episodes", value: "\(episodes)"))
        }
        if !detail.networks.isEmpty {
            items.append(InfoItem(label: "Network", value: detail.networks.prefix(2).joined(separator: ", ")))
        }
        if !detail.creators.isEmpty {
            items.append(InfoItem(label: "Created By", value: detail.creators.prefix(2).joined(separator: ", ")))
        }
        if !detail.countries.isEmpty {
            items.append(InfoItem(label: "Region of Origin", value: detail.countries.joined(separator: ", ")))
        }
        return items
    }

    private func languageItems(_ detail: TVShowDetail) -> [InfoItem] {
        var items: [InfoItem] = []
        if let original = DetailFormat.languageName(code: detail.originalLanguageCode) {
            items.append(InfoItem(label: "Original Audio", value: original))
        }
        if !detail.spokenLanguages.isEmpty {
            items.append(InfoItem(label: "Audio", value: detail.spokenLanguages.prefix(5).joined(separator: ", ")))
        }
        return items
    }

    private func accessibilityItems() -> [InfoItem] {
        [InfoItem(label: "SDH & Audio Description", value: "Varies by provider")]
    }
}

// MARK: - Episode card

struct EpisodeCard: View {
    let episode: TMDBEpisode
    let showBackdropPath: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Color(white: 0.14)
                .frame(width: 280, height: 158)
                .overlay {
                    AsyncImage(url: imageURL) { phase in
                        if case .success(let image) = phase {
                            image.resizable().scaledToFill()
                        } else {
                            Image(systemName: "play.tv")
                                .font(.system(size: 28))
                                .foregroundColor(.white.opacity(0.25))
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.1), lineWidth: 1))

            HStack(alignment: .top) {
                Text(titleLine)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Spacer(minLength: 6)
                if let runtime = DetailFormat.runtime(episode.runtime) {
                    Text(runtime)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.55))
                }
            }
            .frame(width: 280, alignment: .leading)

            if let overview = episode.overview.nonEmpty {
                Text(overview)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.65))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(width: 280, alignment: .leading)
            }
        }
        .frame(width: 280)
    }

    private var titleLine: String {
        let name = episode.name.nonEmpty ?? "Episode \(episode.episodeNumber)"
        return "\(episode.episodeNumber). \(name)"
    }

    /// Episode still, falling back to the show backdrop when TMDB has no still.
    private var imageURL: URL? {
        TMDBImage.url(episode.stillPath, size: "w500")
            ?? TMDBImage.url(showBackdropPath, size: "w500")
    }
}

// ======================================================================
// MARK: FROM FullScreenTrailerView.swift
// ======================================================================
//struct FullScreenTrailerView: View {
//    let videoKey: String
//    let title: String
//
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//
//            TMDBTrailerWebView(videoKey: videoKey)
//                .ignoresSafeArea()
//
//            VStack {
//                HStack {
//                    Spacer()
//                    Button { dismiss() } label: {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.system(size: 34))
//                            .foregroundColor(.white.opacity(0.85))
//                            .shadow(color: .black.opacity(0.4), radius: 5)
//                    }
//                    .padding(.top, 50)
//                    .padding(.trailing, 20)
//                }
//                Spacer()
//
//                // Fallback for embeds that won't play inline.
//                if let url = URL(string: "https://www.youtube.com/watch?v=\(videoKey)") {
//                    Link(destination: url) {
//                        Label("Watch on YouTube", systemImage: "arrow.up.forward.app")
//                            .font(.footnote.weight(.semibold))
//                            .foregroundColor(.white.opacity(0.85))
//                            .padding(.horizontal, 16)
//                            .frame(height: 40)
//                            .background(.ultraThinMaterial, in: Capsule())
//                    }
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//        .onAppear { configureAudioSession() }
//    }
//
//    private func configureAudioSession() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print("Audio session error: \(error)")
//        }
//    }
//}
