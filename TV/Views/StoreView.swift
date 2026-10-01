//
//  StoreView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//

import SwiftUI
import Combine
import UIKit

struct StoreView: View {
    @StateObject private var viewModel = StoreViewModel()
     @State private var showAccountSheet = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Scrollable Hero Section
                    if !viewModel.featuredContent.isEmpty {
                        StoreScrollableHeroView(items: viewModel.featuredContent, viewModel: viewModel)
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
                Text("Store")
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

class StoreViewModel: ObservableObject {
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
    //  REPLACEMENT for setupCustomMovies() in StoreView.swift ONLY
    //  - featuredContent (hero) is LEFT UNCHANGED (your original IDs kept).
    //  - All rows below use REAL TMDB IDs, DIFFERENT from Home & AppleTV, tagged
    //    with .mediaType so they open the correct detail screen + play trailers.
    //
    //  HOW TO USE: in StoreView.swift, replace the ENTIRE setupCustomMovies()
    //  function (from `func setupCustomMovies() {` to its closing `}`) with this.
    // =============================================================================

        func setupCustomMovies() {
            //MARK: Featured Movies (for hero carousel) — UNCHANGED
            featuredContent = [
                MovieBuilder()
                    .id(299536)
                    .posterPath("/3c9jdF9GpG0rMCAlc62rvcqsPaZ.jpg")
                    .backdropPath("/aZX7T1BGqbB498sVPcNsJygMQSx.jpg")
                    .build(),

                MovieBuilder()
                    .id(49026)
                    .posterPath("/qJ2tW6WMUDux911r6m7haRef0WH.jpg")
                    .backdropPath("/9DWGQY8ol0UOVU6l5uPWic2D3jt.jpg")
                    .build(),

                MovieBuilder()
                    .id(361743)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/edWZgyK7jml98nyuLkh80eLbpdv.jpg")
                    .build(),

                MovieBuilder()
                    .id(343611)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/4CUCDxx4YISuiTNmwWndLVXul3A.jpg")
                    .build(),

                MovieBuilder()
                    .id(324552)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/jXjZBPdbptIuYKUtVb8nda3wZSH.jpg")
                    .build(),

                MovieBuilder()
                    .id(263115)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/eVLAhf2Turkmi0FmWdc4PylnAT1.jpg")
                    .build(),

                MovieBuilder()
                    .id(725201)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/8pQPSVhhIr1Mu7X4X2vnCwCb0pb.jpg")
                    .build(),

                MovieBuilder()
                    .id(580489)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/3XjkIY8ZCPSPx6xsLy1sE5ACRm3.jpg")
                    .build(),

                MovieBuilder()
                    .id(503736)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/kztlf79KylNpQNmZRzyagz9tLno.jpg")
                    .build(),

                MovieBuilder()
                    .id(370172)
                    .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                    .backdropPath("/2VzhGr20bkA1xBC8dDjMDVhVYyH.jpg")
                    .build()
            ]

            //MARK: Continue Watching — real TV shows
            continueWatching = [
                MovieBuilder().id(82856).mediaType("tv")
                    .posterPath("/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg")
                    .backdropPath("/9zcbqSxdsRMZWHYtyCd1nXPr2xq.jpg").build(),
                MovieBuilder().id(92749).mediaType("tv")
                    .posterPath("/x6FsYvt33846IQnDSFxla9j0RX8.jpg")
                    .backdropPath("/1uegR4uAxRxiMyX4nQnpzbXhrTw.jpg").build(),
                MovieBuilder().id(114695).mediaType("tv")
                    .posterPath("/EpDuYIK81YtCUT3gH2JDpyj8Qk.jpg")
                    .backdropPath("/2jPv3B0ikeGjEYZKDX8vJGXJrvh.jpg").build(),
                MovieBuilder().id(136315).mediaType("tv")
                    .posterPath("/eKfVzzEazSIjJMrw9ADa2x8ksLz.jpg")
                    .backdropPath("/aJtG4txtmiRHwAAqENQHZvBs6kY.jpg").build(),
                MovieBuilder().id(157741).mediaType("tv")
                    .posterPath("/hYthRgS1nvQkGILn9YmqsF8kSk6.jpg")
                    .backdropPath("/mh2UczqEXJJVgqohbyZbHTuxwhL.jpg").build(),
            ]

            //MARK: Top 10 TV Shows — real TV
            myFavorites = [
                MovieBuilder().id(2190).mediaType("tv")
                    .posterPath("/k7n2EVge7G77eMr3brztRGG1fFU.jpg")
                    .backdropPath("/3UviYOlhn8EgXMBuiT6MnUuo1w9.jpg").build(),
                MovieBuilder().id(1920).mediaType("tv")
                    .posterPath("/lA9CNSdo50iQPZ8A2fyVpMvJZAf.jpg")
                    .backdropPath("/dZklTql88IDOmkC3JAYQSTgyK6f.jpg").build(),
                MovieBuilder().id(100088).mediaType("tv")
                    .posterPath("/dmo6TYuuJgaYinXBPjrgG9mB5od.jpg")
                    .backdropPath("/lY2DhbA7Hy44fAKddr06UrXWWaQ.jpg").build(),
                MovieBuilder().id(125988).mediaType("tv")
                    .posterPath("/r2QXomqKjkKHVtYGGtkf2l2Y7go.jpg")
                    .backdropPath("/uTWhbLc7Bj4qNSdW3ZvZKL8cOHv.jpg").build(),
                MovieBuilder().id(203857).mediaType("tv")
                    .posterPath("/cOKXV0FalCYixNmZYCfHXgyQ0VX.jpg")
                    .backdropPath("/v6f9FUDDQfGIv8MLRQwlL0zvRjI.jpg").build(),
                MovieBuilder().id(138501).mediaType("tv")
                    .posterPath("/mGsxKwXUjojitRv2E9qMTbxbBRd.jpg")
                    .backdropPath("/tYLXJW1sZQU09VWY1BhSVPKGIwc.jpg").build(),
                MovieBuilder().id(90802).mediaType("tv")
                    .posterPath("/q54qEgagGOYCq5D1903eBVMNkbo.jpg")
                    .backdropPath("/i8taDLjpF8cCbp53N8kOFt1LSkW.jpg").build(),
                MovieBuilder().id(73586).mediaType("tv")
                    .posterPath("/peNC0eyc3TQJa6x4TdKcBPNP4t0.jpg")
                    .backdropPath("/ynSOcgDLZfdLCZfRSYZGiTgYJVo.jpg").build(),
            ]

            //MARK: Top 10 TV Movies — real movies
            myCustomRow1 = [
                MovieBuilder().id(346698).mediaType("movie")
                    .posterPath("/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg")
                    .backdropPath("/1esAE8sLJRWWFsLLeh5r3g2WanI.jpg").build(),
                MovieBuilder().id(420808).mediaType("movie")
                    .posterPath("/9NXAlFEE7WDssbXSMgdacsUD58Y.jpg")
                    .backdropPath("/8HfjrSxfTVKmjNh8cJjbu5eXzcX.jpg").build(),
                MovieBuilder().id(324544).mediaType("movie")
                    .posterPath("/dDlfjR7gllmr8HTeN6rfrYhTdwX.jpg")
                    .backdropPath("/oI5uHu7lrQ0mBBH1c8OHCAkCq4x.jpg").build(),
                MovieBuilder().id(438148).mediaType("movie")
                    .posterPath("/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")
                    .backdropPath("/wZS4xSfPtk1NPQnx9zsT5R2WhCu.jpg").build(),
                MovieBuilder().id(568124).mediaType("movie")
                    .posterPath("/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg")
                    .backdropPath("/3G1Q5xF40HkUBJXxt2DQgQzKTp5.jpg").build(),
                MovieBuilder().id(539972).mediaType("movie")
                    .posterPath("/1GvBhRxY6MELDfxFrete6BNhBB5.jpg")
                    .backdropPath("/bGGjyPqtNc8hhGkPo8W8D8t90bW.jpg").build(),
                MovieBuilder().id(150540).mediaType("movie")
                    .posterPath("/2H1TmgdfNtsKlU9jKdeNyYL5y8T.jpg")
                    .backdropPath("/jJKZaTBNenlFclQyjrnvzkRmvWE.jpg").build(),
                MovieBuilder().id(646385).mediaType("movie")
                    .posterPath("/nD4M4Bx457ryLuKYpxFwQ2IBJ5w.jpg")
                    .backdropPath("/ifUfE79O1raUwbaQRIB7XnFz5ZC.jpg").build(),
            ]

            //MARK: Custom Row 2 (Adrenaline-Pumping Action — big feature cards) — your titles, real IDs
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
                MovieBuilder().id(69050).mediaType("tv")
                    .posterPath("/d8mmn9thQ5dBk2qbv6BCqGUXWK3.jpg")
                    .backdropPath("/kb9XvtEnDhBVVit4eeKygqll4EA.jpg").build(),
                MovieBuilder().id(90462).mediaType("tv")
                    .posterPath("/sdCJbGkvnIsIKLxaFQrviriODVq.jpg")
                    .backdropPath("/lyZmMTwpr6ZCXKA7lszpXcDwNOM.jpg").build(),
                MovieBuilder().id(71728).mediaType("tv")
                    .posterPath("/kidkbZRBGbsEIrX7pODRSKi9ipl.jpg")
                    .backdropPath("/nlDBlCtorM7nx130wYnfR5ZmyLX.jpg").build(),
                MovieBuilder().id(69478).mediaType("tv")
                    .posterPath("/eGUT7j3n3rn5yGihlCgwUnD70HV.jpg")
                    .backdropPath("/sokTOq0zAmPS7wCR4qd4Kca35x7.jpg").build(),
                MovieBuilder().id(92830).mediaType("tv")
                    .posterPath("/qJRB789ceLryrLvOKrZqLKr2CGf.jpg")
                    .backdropPath("/p3Jmm6d1ShUrJEuU3DYD2K19c66.jpg").build(),
                MovieBuilder().id(63247).mediaType("tv")
                    .posterPath("/8MfgyFHf7XEboZJPZXCIDqqiz6e.jpg")
                    .backdropPath("/rX5hvSRB2k4YoIvRg6Zky52rWk0.jpg").build(),
                MovieBuilder().id(1911).mediaType("tv")
                    .posterPath("/eyTu5c8LniVciRZIOSHTvvkkgJa.jpg")
                    .backdropPath("/aSye04zKzWtUP3U6Cl4bOXc5Ih9.jpg").build(),
                MovieBuilder().id(90766).mediaType("tv")
                    .posterPath("/gFtJaWcLAJJsSzfuWcLSeAS8aVl.jpg")
                    .backdropPath("/63LRRGIWQxvJiW4G1fRyS70ZE6Y.jpg").build(),
            ]

            //MARK: Popular TV Shows — real TV
            myCustomRow4 = [
                MovieBuilder().id(100757).mediaType("tv")
                    .posterPath("/ovDgO2LPfwdVRfvScAqo9aMiIW.jpg")
                    .backdropPath("/fGk5GVPP7qfEHr8b9pzS6AWsOmV.jpg").build(),
                MovieBuilder().id(85937).mediaType("tv")
                    .posterPath("/xUfRZu2mi8jH6SzQEJGP6tjBuYj.jpg")
                    .backdropPath("/3GQKYh6Trm8pxd2AypovoYQf4Ay.jpg").build(),
                MovieBuilder().id(92782).mediaType("tv")
                    .posterPath("/3HWWh92kZbD7odwJX7nKmXNZsYo.jpg")
                    .backdropPath("/mfcLUWASJghU8MTNK38eYktfE83.jpg").build(),
                MovieBuilder().id(114461).mediaType("tv")
                    .posterPath("/eiJeWeCAEZAmRppnXHiTWDcCd3Q.jpg")
                    .backdropPath("/loDy1LWCkPjECjVTRmyKtOoUpNN.jpg").build(),
                MovieBuilder().id(202879).mediaType("tv")
                    .posterPath("/srQbJhLRKoAwRrNN5ga7webPHbC.jpg")
                    .backdropPath("/fciU7RVyfcdsTeksTnBXGPmkKg2.jpg").build(),
                MovieBuilder().id(110316).mediaType("tv")
                    .posterPath("/Ac8ruycRXzgcsndTZFK6ouGA0FA.jpg")
                    .backdropPath("/QZaPkNUvhdcKONuO2fXuqtcQRo.jpg").build(),
                MovieBuilder().id(84958).mediaType("tv")
                    .posterPath("/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg")
                    .backdropPath("/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg").build(),
                MovieBuilder().id(97546).mediaType("tv")
                    .posterPath("/uRHsiw1wLxPHFXkkv4Ix1s0O6f4.jpg")
                    .backdropPath("/nE94ejEbzNCU48bW1oju0dqBONz.jpg").build(),
            ]

            //MARK: Coming to Apple TV — real movies
            myCustomRow5 = [
                MovieBuilder().id(640146).mediaType("movie")
                    .posterPath("/qnqGbB22YJ7dSs4o6M7exTpNxPz.jpg")
                    .backdropPath("/m8JTwHFwX7I7JY5fPe4SjqejWag.jpg").build(),
                MovieBuilder().id(447365).mediaType("movie")
                    .posterPath("/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg")
                    .backdropPath("/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg").build(),
                MovieBuilder().id(609681).mediaType("movie")
                    .posterPath("/9GBhzXMFjgcZ3FdR9w3bUMMTps5.jpg")
                    .backdropPath("/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg").build(),
                MovieBuilder().id(616037).mediaType("movie")
                    .posterPath("/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")
                    .backdropPath("/jsoz1HlxczSuTx0mDl2h0lxy36l.jpg").build(),
                MovieBuilder().id(634649).mediaType("movie")
                    .posterPath("/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
                    .backdropPath("/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg").build(),
                MovieBuilder().id(505642).mediaType("movie")
                    .posterPath("/sv1xJUazXeYqALzczSZ3O6nkH75.jpg")
                    .backdropPath("/83H0C66AcvkwpG2738VCTHMY9uv.jpg").build(),
                MovieBuilder().id(10138).mediaType("movie")
                    .posterPath("/6WBeq4fCfn7AN0o21W9qNcRF2l9.jpg")
                    .backdropPath("/7lmBufEG7P7Y1HClYK3gCxYrkgS.jpg").build(),
                MovieBuilder().id(299534).mediaType("movie")
                    .posterPath("/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg")
                    .backdropPath("/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg").build(),
            ]

            //MARK: Top Movies to Buy or Rent — real movies
            myCustomRow6 = [
                MovieBuilder().id(338762).mediaType("movie")
                    .posterPath("/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg")
                    .backdropPath("/zlqMASc3vEtdym2OvXgE7fC6onT.jpg").build(),
                MovieBuilder().id(580489).mediaType("movie")
                    .posterPath("/pzKsRuKLFmYrW5Q0q8E8G78Tcgo.jpg")
                    .backdropPath("/eENEf62tMXbhyVvdcXlnQz2wcuT.jpg").build(),
                MovieBuilder().id(460458).mediaType("movie")
                    .posterPath("/bArhvjRHl535XMaSh9VjInF2mSZ.jpg")
                    .backdropPath("/wYtEvBmpBRXPdwGgr1gcWiwJSI7.jpg").build(),
                MovieBuilder().id(882598).mediaType("movie")
                    .posterPath("/aPqcQwu4VGEewPhagWNncDbJ9Xp.jpg")
                    .backdropPath("/kMZIMqEXO5MFd5Y1Ha2jZZF4pvF.jpg").build(),
                MovieBuilder().id(507089).mediaType("movie")
                    .posterPath("/7BpNtNfxuocYEVREzVMO75hso1l.jpg")
                    .backdropPath("/7NRGAtu8E4343NSKwhkgmVRDINw.jpg").build(),
                MovieBuilder().id(646097).mediaType("movie")
                    .posterPath("/xEt2GSz9z5rSVpIHMiGdtf0czyf.jpg")
                    .backdropPath("/cyKH7pDFlxIXluqRyNoHHEpxSDX.jpg").build(),
                MovieBuilder().id(762504).mediaType("movie")
                    .posterPath("/AcKVlWaNVVVFQwro3nLXqPljcYA.jpg")
                    .backdropPath("/yRutvYkM3OP8N9oqqfjSK1VC7fs.jpg").build(),
                MovieBuilder().id(760104).mediaType("movie")
                    .posterPath("/lopZSVtXzhFY603E9OqF7O1YKsh.jpg")
                    .backdropPath("/o375tDNib7tihlkWdtLW1fQhNL1.jpg").build(),
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
                    self?.trendingMovies = response.results
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
                    self?.popularShows = response.results
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
    StoreView()
}

// MARK: - AppleTV Scrollable Hero View
struct StoreScrollableHeroView: View {
    let items: [MediaContent]
    let viewModel: StoreViewModel
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                StoreHeroCard(content: item, viewModel: viewModel)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.75)
    }
}


// MARK: - AppleTV Hero Card
struct StoreHeroCard: View {
    let content: MediaContent
    let viewModel: StoreViewModel
    
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
