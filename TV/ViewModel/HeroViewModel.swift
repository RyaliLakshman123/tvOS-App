//
//  HeroViewModel.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import Foundation
import Combine

@MainActor
class HeroViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var trailerKey: String?

    private let service = MovieService()

    init() {
        bind()
        service.fetchFeaturedMovie()
    }

    private func bind() {
        service.$featuredMovie
            .assign(to: &$movie)

        service.$videoKey
            .assign(to: &$trailerKey)
    }
}
