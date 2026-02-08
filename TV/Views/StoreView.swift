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
    
    private let apiKey = "8d0e5bb27c4c28904e24b540f7415a84"
    
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
    func setupCustomMovies() {
        //MARK: Featured Movies (for hero carousel)
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
        
        //MARK: Continue Watching
        continueWatching = [
            MovieBuilder()
                .id(11)
                .title("F1")
                .posterPath("/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
                .backdropPath("/rN06V2awobzXQ2UURobgYpIoSo.jpg")
                .overview("Paul Atreides arrives on the most dangerous planet")
                .rating(8.0)
                .build(),
            
            MovieBuilder()
                .id(12)
                .title("Ballerina")
                .posterPath("/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
                .backdropPath("/rIeaf2NLSlw11wT8IoBocHhid1y.jpg")
                .overview("Spider-Man's identity is revealed")
                .rating(8.2)
                .build(),
            
            MovieBuilder()
                .id(13)
                .title("The Accountant 2")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/mp1ekOkuE7dHB1KHPQrKlrasDjE.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
            //
            MovieBuilder()
                .id(14)
                .title("Havoc")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/f9p5FdP8CAjm4VujEIS5EJYqiCb.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(15)
                .title("The Adam Project")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/fqRlhvCNauWKycI3f4pJ3vexOP4.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
        ]
        
        //MARK: My Favorites
        myFavorites = [
            MovieBuilder()
                .id(16)
                .posterPath("/onnYrRDxvfEAjeXHxq1BoyUF419.jpg")
                .backdropPath("/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")
                .overview("Two imprisoned men bond over a number of years")
                .rating(9.3)
                .build(),
            
            MovieBuilder()
                .id(17)
                .posterPath("/kkk3YT5gIu4J22tDkl23am8Qf3S.jpg")
                .backdropPath("/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg")
                .overview("The lives of two mob hitmen, a boxer, and more")
                .rating(8.9)
                .build(),
            
            MovieBuilder()
                .id(18)
                .posterPath("/AoGsDM02UVt0npBA8OvpDcZbaMi.jpg")
                .backdropPath("/mI8uqf7QtHUheYn4DwGFtEADsFR.jpg")
                .overview("The presidencies of Kennedy and Johnson unfold")
                .rating(8.8)
                .build(),
            
            MovieBuilder()
                .id(19)
                .posterPath("/nyy3BITeIjviv6PFIXtqvc8i6xi.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(20)
                .posterPath("/ouudK6RCNnsbT1CSXrlATXQIQTG.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(21)
                .posterPath("/eve7CQBM3QXbU2oNbS73WDPV8FM.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(22)
                .posterPath("/wjBdhUaDGKAAUSTxkUm6zPaXHxH.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(23)
                .posterPath("/3hS2kWhrFo7643HqracnZQ6JRtn.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(24)
                .posterPath("/j9nAfPK8csOMMZ9tjPLsiQIV0H2.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(25)
                .posterPath("/dsS0z0uNlvdRcCKDO04Bu3x6Ljd.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build()
        ]
        
        //MARK: Custom Row 1
        myCustomRow1 = [
            MovieBuilder()
                .id(26)
                .posterPath("/aubUUwYeXjJjVzVUIRMiJnWbeXH.jpg")
                .backdropPath("/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg")
                .overview("A former Roman General sets out to exact vengeance")
                .rating(8.5)
                .build(),
            
            MovieBuilder()
                .id(27)
                .posterPath("/pCPA28AkcQBwfYttt3neuYLVhwq.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(28)
                .posterPath("/bqSvOcl1Px0DqS1WHAjHjFtsp7Y.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(29)
                .posterPath("/3f6MAm9BnC4QTtYZgcgdaULn84x.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(30)
                .posterPath("/6WnsS5seWyJ8PdrhXfZ4ghAytMC.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(31)
                .posterPath("/gqziia3o1DyvNTw2Z4BWP2yDnmj.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(32)
                .posterPath("/c9Xsdp06L64lfnDYrW153QHkgXw.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(33)
                .posterPath("/rfILqO261qnYUEIrqWY4P9KpMjz.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(34)
                .posterPath("/9dzWZHteqZb0vuJM4UHHNUAQ56k.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build(),
            
            MovieBuilder()
                .id(35)
                .posterPath("/kixBDddrLlUxjMEp8p0c6aZLp70.jpg")
                .backdropPath("/tmU7GeKVybMWFButWEGl2M4GeiP.jpg")
                .overview("The aging patriarch of an organized crime dynasty")
                .rating(9.2)
                .build()
        ]
        
        //MARK: Custom Row 2
        myCustomRow2 = [
            MovieBuilder()
                .id(36)
                .title("F1")
                .posterPath("/aubUUwYeXjJjVzVUIRMiJnWbeXH.jpg")
                .backdropPath("/mSolqF3SgMhztexfxWmr8a7UXol.jpg")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(37)
                .title("Hijack")
                .posterPath("/uxzzxijgPIY7slzFvMotPv8wjKA.jpg")
                .backdropPath("/9An1tvkAoOqUH8g6hYclXY0ZSfX.jpg")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(38)
                .title("Dies Irae")
                .posterPath("/qnrrdmcPFBJig3CvkRtpfo5qgzH.jpg")
                .backdropPath("/t7JSPlrBfbTmq2TN869vP3L2on3.jpg")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(39)
                .title("Wake Up Dead Man")
                .posterPath("/xIRcG4qmIbzQ0VAsn9nUBf0PIsc.jpg")
                .backdropPath("/xIRcG4qmIbzQ0VAsn9nUBf0PIsc.jpg")
                .rating(7.9)
                .build(),
            
//            MovieBuilder()
//                .id(40)
//                .title("The Mosquito Coast")
//                .posterPath("/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")
//                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
//                .rating(7.9)
//                .build()
        ]
        
        //MARK: Custom Row 3
        myCustomRow3 = [
            MovieBuilder()
                .id(41)
                .posterPath("/9debuCQHgEGX7r1ZrynN5Zpth5f.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(42)
                .posterPath("/rYq7ANuJz4Qhw1DcjCKEzhbyBYn.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(43)
                .posterPath("/57jIwdbEf6m8FG3B94eMHnDIFoh.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(44)
                .posterPath("/ceGqc6xYCCoxNjO2OYFUvdqo9KK.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(45)
                .posterPath("/lOw1gg0MwgYmTxNVOM1eD90VPHR.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(46)
                .posterPath("/kSrInK0iE8TkI2UKD2Xd2kymroX.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(47)
                .posterPath("/tDf1ajYC5DgFY6gLXixkiEtlWIB.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(48)
                .posterPath("/7dUyGyrBY2SgwHJjvH63GCbsM76.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(49)
                .posterPath("/iLmxdfZWdyS2GGXuOMV4YvMqZQf.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(50)
                .posterPath("/2fIajmZGk14ztmPviH3mrkWztmA.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build()
        ]
        
        //MARK: Custom Row 4
        myCustomRow4 = [
            MovieBuilder()
                .id(51)
                .posterPath("/pccmXBaw0j7KZHO52lYLI93trSO.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(52)
                .posterPath("/83UnsV586owYilK4poeMKwb6cm0.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(53)
                .posterPath("/kHOs6noE8L2bDmq83sThNncIZMq.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(54)
                .posterPath("/grFHRwBSlRDM7NvleNQYBCWAgRI.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(55)
                .posterPath("/LWjGRZ6BhQwaBlpQUJ5thEuqym.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(56)
                .posterPath("/cTS86RwEBIDgCgUmjWQTSoPsK6p.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(57)
                .posterPath("/Ah5KZ4UsL5JYwhrgZ68Atphmm8B.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(58)
                .posterPath("/zLNDKKyQE2mKforSBmPBPpbv1e7.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(59)
                .posterPath("/7R38o8G1KdzN3rqym5TnA7vJtz0.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(60)
                .posterPath("/5AZm9IzkjEXAXwfEKDxGxzjXtIV.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build()
        ]
        
        //MARK: Custom Row 5
        myCustomRow5 = [
            MovieBuilder()
                .id(61)
                .posterPath("/g23DQqqTs4OuYDgxzRugVpRnztY.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(62)
                .posterPath("/1D3kjeh9PD5AVSW3CLjWTU5AgBq.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(63)
                .posterPath("/H6hWMo5hL16bjiqwE7DtHzgFSI.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(64)
                .posterPath("/9debuCQHgEGX7r1ZrynN5Zpth5f.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(65)
                .posterPath("/8AjKaRsNd0LdbnYf2WNTPlAK3bO.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(66)
                .posterPath("/eF7Rf2wHPtIO9EbqODbnsUyoZ1I.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(67)
                .posterPath("/pzJPvIfq5uCYblwsaBX2A68Dy6B.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(68)
                .posterPath("/laG8EeXzMharzjxlBt0B1yjiNl6.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(69)
                .posterPath("/x5elPNifsbTtZQ4vY1fNIe0d10V.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(70)
                .posterPath("/6CiuqEo90ayn1iXYtTEilELskga.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build()
        ]
        
        //MARK: Custom Row 6
        myCustomRow6 = [
            MovieBuilder()
                .id(71)
                .posterPath("/mSolqF3SgMhztexfxWmr8a7UXol.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(72)
                .posterPath("/gb5NUyCTbiblRmEwQQXQEMAegol.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(73)
                .posterPath("/uwAgWPnu3H6jW0A8s76p6H89gLp.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(74)
                .posterPath("/svXVRoRSu6zzFtCzkRsjZS7Lqpd.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(75)
                .posterPath("/AGKgsPlmamDh2QWXxNoWJtQXkj.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(76)
                .posterPath("/lBYOKAMcxIvuk9s9hMuecB9dPBV.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(77)
                .posterPath("/1DsmuLI4R3U0Pic8C7A5hfdkvGx.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(78)
                .posterPath("/w0sELjuU16E0a7CpR6zV3ErTONS.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(79)
                .posterPath("/jKE4GGhhSLf4HR2fpD9Ayo2UtAD.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(80)
                .posterPath("/aB9hyjRlVwQDMnKEZeEG6TS1mQQ.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(81)
                .posterPath("/myRHYxfLpgwwRd13kcrRqxG6jAj.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(82)
                .posterPath("/3lTAQ8dNZG2j2Ub3l86ZHn2krQW.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(83)
                .posterPath("/eJQvfXuDPOgxNPdV7lWWHH5v6Fc.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(84)
                .posterPath("/yCAzT42NfSuckAZKWg5FvR4pUVc.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(85)
                .posterPath("/2kopLoDIFpj8dFeAo2hIwyvFZN3.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(86)
                .posterPath("/jykA5xF1uA41yoy91B7OErg4YO7.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(87)
                .posterPath("/8pQPSVhhIr1Mu7X4X2vnCwCb0pb.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(88)
                .posterPath("/u6OAo6eZOL2CNJxYivvOd3tnDC2.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(89)
                .posterPath("/xm6zgCTnLjyn2Wrjbp96buutXJy.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(90)
                .posterPath("/qJ2tW6WMUDux911r6m7haRef0WH.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build()
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
