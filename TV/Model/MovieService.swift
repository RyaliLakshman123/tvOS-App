//
//  MovieService.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//


import Foundation
import Combine

class MovieService: ObservableObject {

    @Published var featuredMovie: Movie?
    @Published var videoKey: String?

    private let apiKey = "8d0e5bb27c4c28904e24b540f7415a84"
    private let movieID = 1060046

    func fetchFeaturedMovie() {
        guard let url = URL(
            string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US"
        ) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data else { return }

            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self?.featuredMovie = movie
                    self?.fetchMovieVideo(movieID: movie.id)
                }
            } catch {
                print("Movie decode error:", error)
            }
        }.resume()
    }

    func fetchMovieVideo(movieID: Int) {
        guard let url = URL(
            string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)"
        ) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data else { return }

            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)

                let trailer =
                    response.results.first {
                        $0.site == "YouTube" && $0.type == "Trailer" && $0.official
                    }
                    ?? response.results.first {
                        $0.site == "YouTube"
                    }

                DispatchQueue.main.async {
                    self?.videoKey = trailer?.key
                }
            } catch {
                print("Video decode error:", error)
            }
        }.resume()
    }
}
