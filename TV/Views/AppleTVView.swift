//
//  AppleTVView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//

import SwiftUI
import Combine
import UIKit

struct AppleTVView: View {
    @StateObject private var viewModel = AppleTVViewModel()
     @State private var showAccountSheet = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Scrollable Hero Section
                    if !viewModel.featuredContent.isEmpty {
                        AppleTVScrollableHeroView(items: viewModel.featuredContent, viewModel: viewModel)
                    }
                    
                    // Content Rows with Glass Effect
                    VStack(spacing: 35) {
                        // Continue Watching Row
                        if !viewModel.continueWatching.isEmpty {
                            MovieRow(
                                title: "Continue Watching",
                                items: viewModel.continueWatching,
                                showProgress: true,
                                cardSize: .medium
                            )
                        }
                        
                        // My Favorites
                        if !viewModel.myFavorites.isEmpty {
                            MovieRow(
                                title: "Top 10 TV Shows",
                                items: viewModel.myFavorites,
                                cardSize: .top10
                            )
                        }
                        
                        // Custom Row 1
                        if !viewModel.myCustomRow1.isEmpty {
                            MovieRow(
                                title: "Top 10 TV Movies",
                                items: viewModel.myCustomRow1,
                                cardSize: .top10
                            )
                        }
                        
                        // Custom Row 2
                        if !viewModel.myCustomRow2.isEmpty {
                            FamiliesRow(title: "Adrenaline-Pumping Action", items: viewModel.myCustomRow2)
                        }
                        
                        // Top Picks for You (from TMDB)
                        if !viewModel.myCustomRow3.isEmpty {
                            MovieRow(
                                title: "Thrills & Chills",
                                items: viewModel.myCustomRow3,
                                cardSize: .top10
                            )
                        }
                        
//                        // New Releases (from TMDB)
//                        if !viewModel.newReleases.isEmpty {
//                            MovieRow(
//                                title: "New Releases",
//                                items: viewModel.newReleases,
//                                cardSize: .large
//                            )
//                        }
                        
                        // Popular Shows (from TMDB)
                        if !viewModel.myCustomRow4.isEmpty {
                            MovieRow(
                                title: "Popular TV Shows",
                                items: viewModel.myCustomRow4,
                                cardSize: .top10
                            )
                        }
                        
                        // Action Movies (from TMDB)
                        if !viewModel.myCustomRow5.isEmpty {
                            MovieRow(
                                title: "Coming to Apple TV",
                                items: viewModel.myCustomRow5,
                                cardSize: .top10
                            )
                        }
                        
                        // Static featured poster (replaces Comedy Movies)
                        FeaturedAssetCard(
                            title: "",
                            assetName: "F1",
                            height: 450  // adjust height to taste
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                        
                        // Action Movies (from TMDB)
                        if !viewModel.myCustomRow6.isEmpty {
                            MovieRow(
                                title: "Top Movies to Buy or Rent",
                                items: viewModel.myCustomRow6,
                                cardSize: .top10
                            )
                        }
                    }
                    
                    // --- Explore Channels & Apps (replaces Trending) ---
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Explore Channels & Apps")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal)

                        // Horizontal scroller with small cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                // Static example using assets (recommended)
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/w500/7gjWVglueBuvfeMSdY2tXhLZRCW.jpg")!),
                                    badgeAsset: "appletv",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face/uROT3bgu8I50EyDA541aozJjYl3.jpg")!),
                                    badgeAsset: "seasonpass",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/original/vYsHsZiaFwkRAQBixKq9GdSgcqW.jpg")!),
                                    badgeAsset: "prime",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/original/aMpUiVX45dHD9XNsvDCEi0i4vrO.jpg")!),
                                    badgeAsset: "zee5",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/original/il3ao5gcF6fZNqo1o9o7lusmEyU.jpg")!),
                                    badgeAsset: "sonyliv",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/original/5mr6nYXd8qXrEVRwvMT6mfcxf2U.jpg")!),
                                    badgeAsset: "lionsgate",
                                    width: 120,
                                    height: 180
                                )
                                ChannelCard(
                                    imageNameOrURL: .url(URL(string: "https://image.tmdb.org/t/p/original/s7C3VGKeSIPUkAQu9NqRuOvQjlD.jpg")!),
                                    badgeAsset: "erosnow",
                                    width: 120,
                                    height: 180
                                )

                                // If you want to use viewModel.trendingMovies (poster URLs) instead, uncomment below:
                                /*
                                ForEach(viewModel.trendingMovies.prefix(8), id: \.id) { movie in
                                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? movie.backdropPath ?? "")")
                                    ChannelCard(imageNameOrURL: .url(url!), badgeAsset: nil, width: 120, height: 180)
                                }
                                */
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 18)
                    .padding(.bottom, 80)
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Apple TV")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .fixedSize()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAccountSheet = true
                } label : {
                    Image("sameer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            viewModel.loadContent()
        }
        .sheet(isPresented: $showAccountSheet) {
            AccountBottomSheet()
        }
    }
}

// MARK: - View Model
class AppleTVViewModel: ObservableObject {
    @Published var featuredContent: [MediaContent] = []
    @Published var continueWatching: [MediaContent] = []
    @Published var myFavorites: [MediaContent] = []
    @Published var myCustomRow1: [MediaContent] = []
    @Published var myCustomRow2: [MediaContent] = []
    @Published var myCustomRow3: [MediaContent] = []
    @Published var myCustomRow4: [MediaContent] = []
    @Published var myCustomRow5: [MediaContent] = []
    @Published var myCustomRow6: [MediaContent] = []
    @Published var trendingMovies: [MediaContent] = []
    @Published var newReleases: [MediaContent] = []
    @Published var popularShows: [MediaContent] = []
    @Published var actionMovies: [MediaContent] = []
    @Published var comedyMovies: [MediaContent] = []
    @Published var sciFiMovies: [MediaContent] = []
    @Published var dramaMovies: [MediaContent] = []
    
    private let apiKey = TMDBConfig.apiKey
    
    func loadContent() {
        // Add your custom movies first
        setupCustomMovies()
        
        // Then fetch from TMDB
        fetchTrending()
        fetchPopularShows()
        fetchUpcoming()
        fetchActionMovies()
        fetchComedyMovies()
        fetchSciFiMovies()
        fetchDramaMovies()
    }
    
    // MARK: - Enhanced Trailer Fetching with Multiple Methods
    func fetchTrailerWithFallback(
        for movieID: Int,
        completion: @escaping (TrailerResult) -> Void
    ) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)"
        
        print("🔍 Fetching trailers for movie ID: \(movieID)")
        
        guard let url = URL(string: urlString) else {
            completion(.failure("Invalid URL"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error?.localizedDescription ?? "Network error"))
                }
                return
            }
            
            do {
                let videoResponse = try JSONDecoder().decode(TMDBVideoResponse.self, from: data)
                
                print("🎬 Found \(videoResponse.results.count) videos")
                
                // Priority: Trailer > Teaser > Clip
                let priorityTypes = ["Trailer", "Teaser", "Clip"]
                
                for type in priorityTypes {
                    if let video = videoResponse.results.first(where: {
                        $0.site == "YouTube" && $0.type == type
                    }) {
                        print("✅ Found \(type): \(video.key)")
                        DispatchQueue.main.async {
                            completion(.youtubeKey(video.key))
                        }
                        return
                    }
                }
                
                DispatchQueue.main.async {
                    completion(.failure("No trailer available for this movie"))
                }
                
            } catch {
                print("❌ Decode error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure("Failed to load trailer"))
                }
            }
        }.resume()
    }

    enum TrailerResult {
        case youtubeKey(String)
        case directURL(URL)
        case failure(String)
    }
    
    
    // MARK: - Setup Your Custom Movies Here
    // =============================================================================
    //  REPLACEMENT for setupCustomMovies() in AppleTVView.swift ONLY
    //  - featuredContent (hero) is LEFT UNCHANGED (your original IDs kept).
    //  - All rows below use REAL TMDB IDs, DIFFERENT from HomeView, tagged with
    //    .mediaType so they open the correct detail screen + play trailers.
    //
    //  HOW TO USE: in AppleTVView.swift, replace the ENTIRE setupCustomMovies()
    //  function (from `func setupCustomMovies() {` to its closing `}`) with this.
    // =============================================================================

        func setupCustomMovies() {
            //MARK: Featured Movies (for hero carousel) 
            featuredContent = [
                MovieBuilder()
                    .id(812583)
                    .posterPath("/3c9jdF9GpG0rMCAlc62rvcqsPaZ.jpg")
                    .backdropPath("/4qqGUgr4PVxe5TjIDWZBkQRhEYN.jpg")
                    .build(),

                MovieBuilder()
                    .id(516486)
                    .posterPath("/qJ2tW6WMUDux911r6m7haRef0WH.jpg")
                    .backdropPath("/1FIEmOKr9ypl4bdiizzuJnHDcli.jpg")
                    .build(),

                MovieBuilder()
                    .id(361743)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/lGa5OteNRoEKmc90atknttbUsJG.jpg")
                    .build(),

                MovieBuilder()
                    .id(27205)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/b5OArcllgjpAup9jDV4uahO1OAc.jpg")
                    .build(),

                MovieBuilder()
                    .id(577922)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/gD60HrHf3E1muyaBTiEZVSsqq3Q.jpg")
                    .build(),

                MovieBuilder()
                    .id(96721)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/yqR7mzBKCv1ih6F2cXa0I8vFh3v.jpg")
                    .build(),

                MovieBuilder()
                    .id(1038392)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/fE5q0jHbKZcsqXtRdmfd9rxwGaE.jpg")
                    .build(),

                MovieBuilder()
                    .id(1045938)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/c1r6E95TSsq8YrsTr2QCPj2VW4.jpg")
                    .build(),

                MovieBuilder()
                    .id(575264)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/nFLqAv0YTnZt2P5seXEObP5abrI.jpg")
                    .build(),

                MovieBuilder()
                    .id(559)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/qjhalSrfqe0nXmNflgY76nN4zpn.jpg")
                    .build()
            ]

            //MARK: Continue Watching — real TV shows
            continueWatching = [
                MovieBuilder().id(1668).mediaType("tv")
                    .posterPath("/2koX1xLkpTQM4IZebYvKysFW1Nh.jpg")
                    .backdropPath("/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg").build(),
                MovieBuilder().id(4607).mediaType("tv")
                    .posterPath("/og6S0aTZU6YUJAbqxeKjCa3kY1E.jpg")
                    .backdropPath("/yUOFocKDW7MCC5isx4FK8A68QFp.jpg").build(),
                MovieBuilder().id(60625).mediaType("tv")
                    .posterPath("/owhkU6KRqdXoUQpjV8uyZGPtX58.jpg")
                    .backdropPath("/5BDNWWHweQL0q1fmTv7gmRXfnl4.jpg").build(),
                MovieBuilder().id(46648).mediaType("tv")
                    .posterPath("/zYqVTiHK5ZajYcNzAW7qWte5NWS.jpg")
                    .backdropPath("/v8YFr8BbU9qsO8PYIulzTeM6Qk.jpg").build(),
                MovieBuilder().id(62286).mediaType("tv")
                    .posterPath("/eKt4ELpQZUKGZCKIDobEbwHwk3I.jpg")
                    .backdropPath("/dvDkq5Mcv27vpHRvF1ywFGroh03.jpg").build(),
            ]

            //MARK: Top 10 TV Shows — real TV
            myFavorites = [
                MovieBuilder().id(1398).mediaType("tv")
                    .posterPath("/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg")
                    .backdropPath("/lNpkvX2s8LGB0mjGODMT4o6Up7j.jpg").build(),
                MovieBuilder().id(48866).mediaType("tv")
                    .posterPath("/wHIMMLFsk32wIzDmawWkYVbxFCS.jpg")
                    .backdropPath("/8ZerYKvIaNUJZvAHXYTQu4qTwFw.jpg").build(),
                MovieBuilder().id(63174).mediaType("tv")
                    .posterPath("/ekZobS8isE6mA53RAiGDG93hBxL.jpg")
                    .backdropPath("/ta5oblpMlEcIPIS2YGcq9XEkWK2.jpg").build(),
                MovieBuilder().id(45).mediaType("tv")
                    .posterPath("/aqM6QnuhSXzjHlKbXyKUqxaGiWu.jpg")
                    .backdropPath("/bJROfBstoARn6vOqqPylYLpGYDH.jpg").build(),
                MovieBuilder().id(31911).mediaType("tv")
                    .posterPath("/5ZFUEOULaVml7pQuXxhpR2SmVUw.jpg")
                    .backdropPath("/A6tMQAo6t6eRFCPhsrShmxZLqFB.jpg").build(),
                MovieBuilder().id(1622).mediaType("tv")
                    .posterPath("/8iixmfGx5EIFPdpNvB2JvI3VIqX.jpg")
                    .backdropPath("/ro0tlgnsco4SwbdAgmscLkSlMSL.jpg").build(),
                MovieBuilder().id(60059).mediaType("tv")
                    .posterPath("/fC2HDm5t0kHl7mTm7jxMR31b7by.jpg")
                    .backdropPath("/rfxryDIv8huejujg4JueDJx8zCz.jpg").build(),
                MovieBuilder().id(44217).mediaType("tv")
                    .posterPath("/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg")
                    .backdropPath("/13kblIK8DnxMurcRDkeyy2sGR7v.jpg").build(),
            ]

            //MARK: Top 10 TV Movies — real movies
            myCustomRow1 = [
                MovieBuilder().id(370172).mediaType("movie")
                    .posterPath("/iUgygt3fscRoKWCV1d0C7FbM9TP.jpg")
                    .backdropPath("/bz7pwNGCbV576COsDcYN9MbEACC.jpg").build(),
                MovieBuilder().id(710295).mediaType("movie")
                    .posterPath("/wpSDzTBfF0Eeo5lzu2w9FTujGqd.jpg")
                    .backdropPath("/wwARk7hRIfHfh2n2ubN6N7lvTne.jpg").build(),
                MovieBuilder().id(672).mediaType("movie")
                    .posterPath("/sdEOH0992YZ0QSxgXNIGLq1ToUi.jpg")
                    .backdropPath("/zuYEvft5fuzBDOeq4ClYpiu9LlO.jpg").build(),
                MovieBuilder().id(674).mediaType("movie")
                    .posterPath("/fECBtHlr0RB3foNHDiCBXeg9Bv9.jpg")
                    .backdropPath("/cClWTo3ftVXvV1sF8vlLuWfnlph.jpg").build(),
                MovieBuilder().id(767).mediaType("movie")
                    .posterPath("/z7uo9zmQdQwU5ZJHFpv2Upl30i1.jpg")
                    .backdropPath("/mITJS77BV4TSqdFB5FPGBc7JKXj.jpg").build(),
                MovieBuilder().id(862).mediaType("movie")
                    .posterPath("/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg")
                    .backdropPath("/3Rfvhy1Nl6sSGJwyjb0QiZzZYlB.jpg").build(),
                MovieBuilder().id(863).mediaType("movie")
                    .posterPath("/4rbcp3ng8n1MKHjpeqW0L7Fnpzz.jpg")
                    .backdropPath("/nsfVr4QbbunUrHINN9N7JdVAMTf.jpg").build(),
                MovieBuilder().id(585).mediaType("movie")
                    .posterPath("/wFSpyMsp7H0ttERbxY7Trlv8xry.jpg")
                    .backdropPath("/sDTnMOJ3H5wI38OxObmCtK7wfd5.jpg").build(),
            ]

            //MARK: Custom Row 2 (Adrenaline-Pumping Action — big feature cards) — real movies
            myCustomRow2 = [
                MovieBuilder()
                    .id(911430).mediaType("movie")
                    .title("F1")
                    .posterPath("/9PXZIUsSDh4alB80jheWX4fhZmy.jpg")
                    .backdropPath("/lkDYN0whyE82mcM20rwtwjbniKF.jpg")
                    .rating(8.4)
                    .build(),

                MovieBuilder()
                    .id(198102).mediaType("tv")
                    .title("Hijack")
                    .posterPath("/2C51clnxQdiqPDeqQlXcUx70hse.jpg")
                    .backdropPath("/aRZ7k1M3AdjVv8n3Fi6cAkEdpYY.jpg")
                    .rating(7.3)
                    .build(),

                MovieBuilder()
                    .id(1396869).mediaType("movie")
                    .title("Dies Irae")
                    .posterPath("/123DlTiiezgLaJruVe7RiSi0RFf.jpg")
                    .backdropPath("/8Fl8B1TRkcjkU9VMp9ex9mV6949.jpg")
                    .rating(7.9)
                    .build(),

                MovieBuilder()
                    .id(812583).mediaType("movie")
                    .title("Wake Up Dead Man")
                    .posterPath("/iV9LM8aUb83BjCCx2RUnKE5sSQg.jpg")
                    .backdropPath("/fiRDzpcJe7qz3yIR43hdXIE3NHv.jpg")
                    .rating(7.9)
                    .build()
            ]
            //MARK: Thrills & Chills — real TV
            myCustomRow3 = [
                MovieBuilder().id(1395).mediaType("tv")
                    .posterPath("/ep03M6KKZGeljOizPEbt3Geja5n.jpg")
                    .backdropPath("/5RWAjCYhu3D8Ai2QBYP7GjaxFb3.jpg").build(),
                MovieBuilder().id(60574).mediaType("tv")
                    .posterPath("/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg")
                    .backdropPath("/dzq83RHwQcnP6WGJ6YkenIqeaa5.jpg").build(),
                MovieBuilder().id(1416).mediaType("tv")
                    .posterPath("/hjJkrLXhWvGHpLeLBDFznpBTY1S.jpg")
                    .backdropPath("/jP0Rhj9OTPDAwQlHQwOLFDdeE8t.jpg").build(),
                MovieBuilder().id(456).mediaType("tv")
                    .posterPath("/tf0CUEynk6GfmrlHIQKQ5mfFP5P.jpg")
                    .backdropPath("/qcSHGC5BfoqBoP99PzDIERYG5Qm.jpg").build(),
                MovieBuilder().id(4556).mediaType("tv")
                    .posterPath("/w7ri7byEYLdciSZOwWHj6TUAX7j.jpg")
                    .backdropPath("/rRKTV46DKVP8AfdCQDyQMAtJeCl.jpg").build(),
                MovieBuilder().id(60694).mediaType("tv")
                    .posterPath("/fuuEjEr69uvRtGaQw70JfvdrUwb.jpg")
                    .backdropPath("/q31EEBycbOyX7GGJP4GTPI5WJRO.jpg").build(),
                MovieBuilder().id(1437).mediaType("tv")
                    .posterPath("/vZcKsy4sGAvWMVqLluwYuoi11Kj.jpg")
                    .backdropPath("/te4VJNMipsFQofCkiytuyswGDlV.jpg").build(),
                MovieBuilder().id(71446).mediaType("tv")
                    .posterPath("/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg")
                    .backdropPath("/gFZriCkpJYsApPZEF3jhxL4yLzG.jpg").build(),
            ]

            //MARK: Popular TV Shows — real TV
            myCustomRow4 = [
                MovieBuilder().id(66732).mediaType("tv")
                    .posterPath("/uOOtwVbSr4QDjAGIifLDwpb2Pdl.jpg")
                    .backdropPath("/9P4IIMYY3HifqeruZq0ZZ9g7YUi.jpg").build(),
                MovieBuilder().id(1399).mediaType("tv")
                    .posterPath("/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg")
                    .backdropPath("/zZqpAXxVSBtxV9qPBcscfXBcL2w.jpg").build(),
                MovieBuilder().id(94605).mediaType("tv")
                    .posterPath("/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg")
                    .backdropPath("/5cvnxEHT3e39DvT6ARw4GNCFrB0.jpg").build(),
                MovieBuilder().id(93405).mediaType("tv")
                    .posterPath("/1QdXdRYfktUSONkl1oD5gc6Be0s.jpg")
                    .backdropPath("/2meX1nMdScFOoV4370rqHWKmXhY.jpg").build(),
                MovieBuilder().id(71912).mediaType("tv")
                    .posterPath("/AoGsDM02UVt0npBA8OvpDcZbaMi.jpg")
                    .backdropPath("/foGkPxpw9h8zln81j63mix5B7m8.jpg").build(),
                MovieBuilder().id(85271).mediaType("tv")
                    .posterPath("/ijWWwINc8h71NQ8j1LTJMFSj5wr.jpg")
                    .backdropPath("/cq62fLH3vwOmiaLKMqkDI86tPtH.jpg").build(),
                MovieBuilder().id(76479).mediaType("tv")
                    .posterPath("/in1R2dDc421JxsoRWaIIAqVI2KE.jpg")
                    .backdropPath("/bq28ajZaoMyzEIm6REelqyqtEDZ.jpg").build(),
                MovieBuilder().id(95557).mediaType("tv")
                    .posterPath("/4tblBrslcKSifMVZ3TmtT2ukMor.jpg")
                    .backdropPath("/9qrroces8C6R9aKr08hACNPVXdZ.jpg").build(),
            ]

            //MARK: Coming to Apple TV — real movies
            myCustomRow5 = [
                MovieBuilder().id(575265).mediaType("movie")
                    .posterPath("/iKPsC9EFUafRP9SrUznI61getVP.jpg")
                    .backdropPath("/538U9snNc2fpnOmYXAPUh3zn31H.jpg").build(),
                MovieBuilder().id(822119).mediaType("movie")
                    .posterPath("/pzIddUEMWhWzfvLI3TwxUG2wGoi.jpg")
                    .backdropPath("/ce3prrjh9ZehEl5JinNqr4jIeaB.jpg").build(),
                MovieBuilder().id(1241982).mediaType("movie")
                    .posterPath("/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg")
                    .backdropPath("/vYqt6kb4lcF8wwqsMMaULkP9OEn.jpg").build(),
                MovieBuilder().id(974576).mediaType("movie")
                    .posterPath("/m5x8D0bZ3eKqIVWZ5y7TnZ2oTVg.jpg")
                    .backdropPath("/eZzNdjNDvaSoyywy9ICg2UmFwul.jpg").build(),
                MovieBuilder().id(986056).mediaType("movie")
                    .posterPath("/hqcexYHbiTBfDIdDWxrxPtVndBX.jpg")
                    .backdropPath("/rthMuZfFv4fqEU4JVbgSW9wQ8rs.jpg").build(),
                MovieBuilder().id(1035259).mediaType("movie")
                    .posterPath("/rwla9vqzrKVVKVKiOuROTIXGsxj.jpg")
                    .backdropPath("/1wi1hcbl6KYqARjdQ4qrBWZdiau.jpg").build(),
                MovieBuilder().id(1151031).mediaType("movie")
                    .posterPath("/1Q3GlCXGYWELifxANYZ5OVMRVZl.jpg")
                    .backdropPath("/2IIKts2A9vnUdM9tTC76B8tDmuZ.jpg").build(),
                MovieBuilder().id(617126).mediaType("movie")
                    .posterPath("/nf5qaSEvyYSNeFH0YhSs5EsBLX9.jpg")
                    .backdropPath("/s94NjfKkcSczZ1FembwmQZwsuwY.jpg").build(),
            ]

            //MARK: Top Movies to Buy or Rent — real movies
            myCustomRow6 = [
                MovieBuilder().id(541671).mediaType("movie")
                    .posterPath("/2VUmvqsHb6cEtdfscEA6fqqVzLg.jpg")
                    .backdropPath("/1yktYsxkmUtUFTUnCAUaqG6FEiz.jpg").build(),
                MovieBuilder().id(1022789).mediaType("movie")
                    .posterPath("/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg")
                    .backdropPath("/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg").build(),
                MovieBuilder().id(698687).mediaType("movie")
                    .posterPath("/iRCgqpdVE4wyLQvGYU3ZP7pAtUc.jpg")
                    .backdropPath("/cMfokHWle5lfCreoV08cbmkKv6G.jpg").build(),
                MovieBuilder().id(1307078).mediaType("movie")
                    .posterPath("/jrhXbIOFingzdLjkccjg9vZnqIp.jpg")
                    .backdropPath("/A466i5iATrpbVjX30clP1Zyfp31.jpg").build(),
                MovieBuilder().id(1038392).mediaType("movie")
                    .posterPath("/byWgphT74ClOVa8EOGzYDkl8DVL.jpg")
                    .backdropPath("/i8MupUe4xgmYXoRNAQMYvuoexSU.jpg").build(),
                MovieBuilder().id(1125257).mediaType("movie")
                    .posterPath("/9wV65OmsjLAqBfDnYTkMPutXH8j.jpg")
                    .backdropPath("/yQy9Y3p5INwkfTuHSnzYnz4MCV3.jpg").build(),
                MovieBuilder().id(758323).mediaType("movie")
                    .posterPath("/jFC4LS5qTAT3PinzdEzINfu1CV9.jpg")
                    .backdropPath("/3oqmk6mNWPatBKcjOOJLp5WW9zN.jpg").build(),
                MovieBuilder().id(447273).mediaType("movie")
                    .posterPath("/oLxWocqheC8XbXbxqJ3x422j9PW.jpg")
                    .backdropPath("/tyfO9jHgkhypUFizRVYD0bytPjP.jpg").build(),
            ]
        }
    
    // MARK: - TMDB Fetch Methods (keep all your existing fetch methods)
    private func fetchTrending() {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.trendingMovies = response.results.map { $0.withMediaType("movie") }
                }
            } catch {
                print("Error decoding trending: \(error)")
            }
        }.resume()
    }
    
    private func fetchPopularShows() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.popularShows = response.results.map { $0.withMediaType("tv") }
                }
            } catch {
                print("Error decoding shows: \(error)")
            }
        }.resume()
    }
    
    private func fetchUpcoming() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.newReleases = response.results
                }
            } catch {
                print("Error decoding upcoming: \(error)")
            }
        }.resume()
    }
    
    private func fetchActionMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=28") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.actionMovies = response.results
                }
            } catch {
                print("Error decoding action movies: \(error)")
            }
        }.resume()
    }
    
    private func fetchComedyMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=35") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.comedyMovies = response.results
                }
            } catch {
                print("Error decoding comedy movies: \(error)")
            }
        }.resume()
    }
    
    private func fetchSciFiMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=878") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.sciFiMovies = response.results
                }
            } catch {
                print("Error decoding sci-fi movies: \(error)")
            }
        }.resume()
    }
    
    private func fetchDramaMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&with_genres=18") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.dramaMovies = response.results
                }
            } catch {
                print("Error decoding drama movies: \(error)")
            }
        }.resume()
    }
}

#Preview {
    AppleTVView()
}

// MARK: - AppleTV Scrollable Hero View
struct AppleTVScrollableHeroView: View {
    let items: [MediaContent]
    let viewModel: AppleTVViewModel
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                AppleTVHeroCard(content: item, viewModel: viewModel)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.75)
    }
}

// MARK: - AppleTV Hero Card
struct AppleTVHeroCard: View {
    let content: MediaContent
    let viewModel: AppleTVViewModel
    
    @State private var imageLoaded = false
    @State private var isAdded = false
    @State private var showTrailerPlayer = false
    @State private var trailerKey: String = ""
    @State private var showTrailerError = false
    @State private var errorMessage = ""
    @State private var isLoadingTrailer = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Background Image
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(content.backdropPath ?? "")")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 60)
                            .onAppear { imageLoaded = true }
                    case .failure(_):
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                ProgressView()
                                    .tint(.white)
                            )
                    @unknown default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                
                // Content Info
                VStack(spacing: 20) {
                    // Title
                    Text(content.title ?? content.name ?? "")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.5), radius: 10)
                        .padding(.horizontal)
                    
                    // Overview
                    if let overview = content.overview, !overview.isEmpty {
                        Text(overview)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding(.horizontal, 50)
                    }
                    
                    // Buttons
                    HStack(spacing: 15) {
                        Button {
                            isLoadingTrailer = true
                            viewModel.fetchTrailerWithFallback(for: content.id) { result in
                                isLoadingTrailer = false
                                
                                switch result {
                                case .youtubeKey(let key):
                                    trailerKey = key
                                    showTrailerPlayer = true
                                    print("🎬 Playing YouTube trailer: \(key)")
                                    
                                case .directURL(_):
                                    print("🎬 Direct video URL")
                                    
                                case .failure(let error):
                                    errorMessage = error
                                    showTrailerError = true
                                    print("❌ Trailer error: \(error)")
                                }
                            }
                        } label: {
                            HStack(spacing: 8) {
                                if isLoadingTrailer {
                                    ProgressView()
                                        .tint(.black)
                                        .scaleEffect(0.8)
                                } else {
                                    Image(systemName: "play.fill")
                                    Text("Play")
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(6)
                            .opacity(isLoadingTrailer ? 0.7 : 1.0)
                        }
                        .disabled(isLoadingTrailer)
                        .fullScreenCover(isPresented: $showTrailerPlayer) {
                            TrailerPlayerView(
                                videoKey: trailerKey,
                                movieTitle: content.title ?? content.name ?? "Trailer"
                            )
                        }
                        .alert("Trailer Unavailable", isPresented: $showTrailerError) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text(errorMessage)
                        }

                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                isAdded.toggle()
                            }
                        } label: {
                            Image(systemName: isAdded ? "checkmark" : "plus")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(isAdded ? Color.white.opacity(0.15) : Color.white.opacity(0.15))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 24)
                                                .stroke(isAdded ? Color.white.opacity(0.5) : Color.white.opacity(0.5), lineWidth: 1)
                                        )
                                )
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
                                .scaleEffect(isAdded ? 1.05 : 1.0)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.bottom, 50)
            }
        }
    }
}
