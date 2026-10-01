//
//  MediaDetailDestination.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//



import SwiftUI
import UIKit

enum MediaDetailDestination: Hashable {
    case movie(MediaContent)
    case tv(MediaContent)

    init(_ content: MediaContent) {
        self = content.isTV ? .tv(content) : .movie(content)
    }
}

// MARK: - MediaContent helpers (kept out of HomeView so the Home model stays small)

extension MediaContent {

    /// TMDB: movies have `title`, shows have `name`. An explicit `mediaType`
    /// (set by the builder or by TMDB's `media_type`) always wins.
    var isTV: Bool {
        if let mediaType { return mediaType == "tv" }
        return title == nil && name != nil
    }

    /// Same item, tagged with a media type (used for rows fetched from /tv/... endpoints).
    func withMediaType(_ type: String) -> MediaContent {
        MediaContent(
            id: id,
            title: title,
            name: name,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            youtubeTrailerURL: youtubeTrailerURL,
            trailerKey: trailerKey,
            mediaType: type
        )
    }
}

extension MediaContent: Hashable {
    static func == (lhs: MediaContent, rhs: MediaContent) -> Bool {
        lhs.id == rhs.id && lhs.isTV == rhs.isTV
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isTV)
    }
}

// MARK: - Router view

struct MediaDetailView: View {
    let destination: MediaDetailDestination

    var body: some View {
        switch destination {
        case .movie(let content): MovieDetailView(content: content)
        case .tv(let content):    TVShowDetailView(content: content)
        }
    }
}

// MARK: - Tap target used by every card

/// Wrap any card in this to make it open the correct detail screen.
struct MediaDetailLink<Label: View>: View {
    let content: MediaContent
    @ViewBuilder var label: () -> Label

    var body: some View {
        NavigationLink {
            MediaDetailView(destination: MediaDetailDestination(content))
        } label: {
            label()
        }
        .buttonStyle(CardPressStyle())
    }
}

/// Same press feel the old MovieCard tap gesture had (scale to 0.95 with a spring).
struct CardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
