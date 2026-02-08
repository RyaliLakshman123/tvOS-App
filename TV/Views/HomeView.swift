//
//  HomeView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//

import SwiftUI
import Combine
import UIKit
import WebKit

 struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showAccountSheet = false
    @State private var showTrailer = false
    @State private var trailerKey: String = ""
    @State private var showTrailerPlayer = false
    @State private var selectedTrailerURL: URL?
    @State private var isPlaying = true
     
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Scrollable Hero Section
                    if !viewModel.featuredContent.isEmpty {
                           ScrollableHeroView(items: viewModel.featuredContent, viewModel: viewModel)  // ✅ Pass viewModel
                       }//                    HeroView()

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
                                title: "Top 10 on Apple TV",
                                items: viewModel.myFavorites,
                                cardSize: .top10
                            )
                        }
                        
                        // Custom Row 1
                        if !viewModel.myCustomRow1.isEmpty {
                            MovieRow(
                                title: "New Releases on Apple TV",
                                items: viewModel.myCustomRow1,
                                cardSize: .top10
                            )
                        }
                        
                        // Custom Row 2
                        if !viewModel.myCustomRow2.isEmpty {
                            FamiliesRow(title: "Families On the Run", items: viewModel.myCustomRow2)
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
            .fullScreenCover(isPresented: $showTrailer) {
                ZStack(alignment: .topTrailing) {
                    TMDBTrailerWebView(videoKey: trailerKey)
                        .ignoresSafeArea()
                    
                    Button {
                        showTrailer = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.3), radius: 5)
                            .padding(20)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Home")
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

// MARK: - Scrollable Hero View
struct ScrollableHeroView: View {
    let items: [MediaContent]
    let viewModel: HomeViewModel  // ✅ Regular parameter
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                HeroCard(content: item, viewModel: viewModel)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height * 0.75)
    }
}

// MARK: - Hero Card
struct HeroCard: View {
    let content: MediaContent
    let viewModel: HomeViewModel
    @State private var imageLoaded = false
    @State private var isAdded = false
    @State private var showTrailer = false
//    @State private var trailerURL: URL?
//    @State private var isLoadingTrailer = false
    @State private var showTrailerError = false
//    @State private var showTrailerSheet = false
//    @State private var videoID: String?
    @State private var trailerKey: String = ""
    @State private var trailerKeys: [String] = []
    @State private var currentIndex = 0
    @State private var showTrailerPlayer = false
    @State private var selectedTrailerURL: URL?
    @State private var errorMessage = ""
    @State private var isLoadingTrailer = false
    @State private var isPlaying = true
    
    private func tryNextTrailer() {
        currentIndex += 1
        
        if currentIndex < trailerKeys.count {
            trailerKey = trailerKeys[currentIndex]
        } else {
            showTrailer = false
            showTrailerError = true
            
        }
    }
    
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
                
//                // Gradient Overlay
//                LinearGradient(
//                    colors: [
//                        Color.black.opacity(0),
//                        Color.black.opacity(0.5),
//                        Color.black.opacity(0.9),
//                        Color.black
//                    ],
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
                
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
//        .fullScreenCover(isPresented: $showTrailer) {
//            if let videoID {
//                TrailerPlayerView(videoID: videoID)
//            } else {
//                Text("Trailer unavailable")
//                    .foregroundColor(.white)
//                    .background(Color.black)
//            }
//        HStack(spacing: 8) {
//            Image(systemName: "play.fill")
//                .font(.system(size: 14, weight: .bold))
//
//            Text("Play")
//                .font(.system(size: 20, weight: .semibold))
//        }
//        .foregroundColor(.black)
//        .padding(.horizontal, 28)
//        .padding(.vertical, 10)
//        .background(Color.white)
//        .cornerRadius(25)
        }
    }


// MARK: - Reusable Movie Row
struct MovieRow: View {
    let title: String
    let items: [MediaContent]
    var showProgress: Bool = false
    var cardSize: CardSize = .medium
    
    enum CardSize {
        case small, medium, large, top10
        
        var dimensions: CGSize {
            switch self {
            case .small: return CGSize(width: 140, height: 210)
            case .medium: return CGSize(width: 160, height: 240)
            case .large: return CGSize(width: 200, height: 300)
            case .top10: return CGSize(width: 110, height: 170)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // Section Title
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    // See all action
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight:.bold))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal,-190)
                }
            }
            .padding(.horizontal)
            
            // Horizontal Scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                      ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                         if showProgress {
                             ContinueWatchingCard(content: item)
                         } else {
                             MovieCard(
                                 content: item,
                                 size: cardSize.dimensions,
                                 rank: cardSize == .top10 ? index + 1 : nil   // Only Top 10 gets ranking
                             )
                         }
                     }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }
}

// MARK: - Movie Card with Glass Effect
struct MovieCard: View {
    let content: MediaContent
    let size: CGSize
    var showProgress: Bool = false
    @State private var isPressed = false
    var rank: Int? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Poster Image
            // BACKDROP + POSTER (Apple TV Style)
             ZStack(alignment: .topLeading) {
                
                // 1️⃣ CONTINUE WATCHING → SHOW BACKDROP ONLY
                if showProgress, let backdrop = content.backdropPath {
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w1066_and_h600_face\(backdrop)")
                    ) { phase in
                        switch phase {
                        case .success(let img):
                            img
                                .resizable()
                                .scaledToFill()
                        case .empty:
                            Color.gray.opacity(0.2)
                        default:
                            Color.gray.opacity(0.2)
                        }
                    }
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(12)
                    .clipped()

                } else {
                    // 2️⃣ NORMAL ROWS → SHOW POSTER
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w500\(content.posterPath ?? "")")
                    ) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(ProgressView().tint(.white))
                        @unknown default:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                    }
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(12)
                    .clipped()
                }
                 // Ranking number (Top 10 only)
                 if let rank = rank {
                     Text("\(rank)")
                         .font(.system(size: 40, weight: .heavy))
                         .foregroundStyle(
                             LinearGradient(
                                 colors: [
                                     Color.white.opacity(1.0),   // top = bright white
                                     Color.white.opacity(0.7),   // mid = softer
                                     Color.black.opacity(0.1)    // bottom = slight black
                                 ],
                                 startPoint: .top,
                                 endPoint: .bottom
                             )
                         )
                         .padding(6)
                 }
                 
                // KEEP YOUR GLASS OVERLAY
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(isPressed ? 0.1 : 0),
                                Color.white.opacity(0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.4), radius: 10, y: 5)
            
            // Title
            Text(content.title ?? content.name ?? "Unknown")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(width: size.width, alignment: .leading)
                .padding(.top, 8)
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                // Handle tap - navigate to detail view
            }
        }
    }
}

//MARK: ContinueWatchingCard
 struct ContinueWatchingCard: View {
     let content: MediaContent
     let size: CGSize = CGSize(width: 300, height: 170)  // Apple TV style
     let cornerRadius: CGFloat = 22

     var body: some View {
         ZStack(alignment: .bottomLeading) {

             // BACKDROP IMAGE
             AsyncImage(
                 url: URL(string: "https://image.tmdb.org/t/p/w1066_and_h600_face\(content.backdropPath ?? "")")
             ) { phase in
                 switch phase {
                 case .success(let img):
                     img.resizable().scaledToFill()
                 default:
                     Color.gray.opacity(0.25)
                 }
             }
             .frame(width: size.width, height: size.height)
             .clipped()
             .cornerRadius(cornerRadius)

             // REAL GLASS EFFECT LAYER (Apple TV style)
             RoundedRectangle(cornerRadius: cornerRadius)
                 .fill(.ultraThinMaterial)     // ← Apple glass effect
                 .opacity(0.35)                // ← slightly transparent
                 .blendMode(.overlay)          // ← blends with backdrop
                 .frame(width: size.width, height: size.height)
                 .allowsHitTesting(false)

             // SUBTLE TOP HIGHLIGHT (Apple TV uses this)
             RoundedRectangle(cornerRadius: cornerRadius)
                 .stroke(Color.white.opacity(0.12), lineWidth: 1)
                 .blendMode(.overlay)

             // BOTTOM TEXT OVERLAY (Apple TV style)
             LinearGradient(
                 colors: [.clear, .black.opacity(0.55)],
                 startPoint: .top,
                 endPoint: .bottom
             )
             .frame(height: 70)
             .frame(maxWidth: .infinity, alignment: .bottom)
             .cornerRadius(cornerRadius)

             Text(content.title ?? content.name ?? "")
                 .font(.headline)
                 .fontWeight(.semibold)
                 .foregroundColor(.white)
                 .shadow(radius: 3)
                 .padding(.leading, 14)
                 .padding(.bottom, 12)
         }
         .frame(width: size.width, height: size.height)
         .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
         .shadow(color: .black.opacity(0.5), radius: 12, y: 6)
     }
 }

// MARK: - Families Row (Apple TV Style Feature Row)
struct FamiliesRow: View {
    let title: String
    let items: [MediaContent]

    private var cardSize: CGSize {
        let w = UIScreen.main.bounds.width - 48
        let h = UIScreen.main.bounds.height * 0.60
        return CGSize(width: w, height: h)
    }

    @State private var page = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

//                Image(systemName: "chevron.right")
//                    .font(.system(size: 18, weight:.bold))
//                    .foregroundColor(.white.opacity(0.7))
//                    .padding(.horizontal,-190)
            }
            .padding(.horizontal)

            // FIX: Prevent ScrollView + TabView conflict
            ZStack {
                TabView(selection: $page) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        FamilyCard(content: item, size: cardSize)
                            .tag(index)
                    }
                }
                
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity, minHeight: cardSize.height, maxHeight: cardSize.height)
//            .safeAreaPadding(.horizontal, -30)   // ← MAGIC FIX: reduces spacing
//            .containerRelativeFrame(.horizontal)
            .clipped()
            .animation(.easeInOut, value: page)
            
//            HStack(spacing: 6) {
//                ForEach(0..<min(items.count, 5), id: \.self) { i in
//                    Circle()
//                        .fill(i == page ? Color.white : Color.white.opacity(0.2))
//                        .frame(width: 6, height: 6)
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.top, 4)
        }
    }
}

// MARK: - FamilyCard (Apple TV Glass Featured Card)
struct FamilyCard: View {
    let content: MediaContent
    let size: CGSize
    @State private var sampledColor: Color = .black

    var imageURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/original\(content.backdropPath ?? content.posterPath ?? "")")
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // BACK BLUR LAYER (Apple TV+ style)
            // BACKSIDE GLASS EFFECT (Apple TV accurate)
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.03),
                            Color.black.opacity(0.12)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: size.width, height: size.height)
            
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(content.backdropPath ?? content.posterPath ?? "")")) { phase in
                switch phase {
                case .success(let img):
                    img.resizable()
                        .scaledToFit()
                        .frame(width: size.width, height: size.height)
                        .clipped()
                default:
                    Color.gray.opacity(0.25)
                }
            }
            .task {
                await sampleImageColour()
            }
            .frame(width: size.width, height: size.height)
            .clipped()
            .cornerRadius(20)
            
            // NEW Badge
            VStack {
                HStack {
                    Text("New")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.black.opacity(0.6), in: Capsule())
                        .foregroundColor(.white)
                        .padding(.leading, 14)
                        .padding(.top, 14)
                    Spacer()
                }
                Spacer()
            }

            // Bottom Image-Tinted Gradient & Text
            LinearGradient(
                colors: [
                    sampledColor.opacity(0.0),     // top transparent
                    sampledColor.opacity(0.25),    // mid soft tint
                    sampledColor.opacity(0.95)     // bottom strong tint
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: size.height * 0.90)   // about 40–45% bottom coverage
            .frame(maxWidth: .infinity)
            .overlay(
                VStack(alignment: .leading, spacing: 6) {

                    Text(content.title ?? content.name ?? "")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)

                    HStack(spacing: 8) {
                        Image(systemName: "appletv.fill")
                            .font(.callout)
                        Text("Movie • Comedy • Action")
                            .font(.caption)
                    }
                    .foregroundColor(.white.opacity(0.85))

                    if let overview = content.overview {
                        Text(overview)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 22),
                alignment: .bottomLeading
            )
            .overlay(
                VStack(alignment: .leading, spacing: 6) {

                    // Title
                    Text(content.title ?? content.name ?? "")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)

                    // Category line
                    HStack(spacing: 8) {
                        Image(systemName: "appletv.fill")
                            .font(.callout)
                        Text("Movie • Comedy • Action")
                            .font(.caption)
                    }
                    .foregroundColor(.white.opacity(0.85))
                    
                    // Overview
                    if let overview = content.overview {
                        Text(overview)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 22),
                alignment: .bottomLeading
            )
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: 20))    // ← IMPORTANT FIX
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.6), radius: 18, y: 10)
//        .offset(x: 8)
    }
    
    // MARK: - Sample Average Color From Image
    private func sampleImageColour() async {
        guard let url = imageURL else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            #if os(iOS)
            if let uiImage = UIImage(data: data),
               let avg = uiImage.averageColor(resizeTo: CGSize(width: 8, height: 8)) {

                await MainActor.run {
                    sampledColor = Color(avg)
                }
            }
            #endif
        } catch {
            // fallback stays black
        }
    }
}


//MARK: FeaturedAssetCard
/// A static featured poster card that matches the  Apple TV style.
struct FeaturedAssetCard: View {
    let title: String
    let assetName: String
    let height: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            // Black background so the image appears like a poster on black
            Color.black
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.6), radius: 18, y: 10)

            // Poster image from assets
            Image(assetName)
                .resizable()
                .scaledToFill()
                .scaleEffect(1.08)
                .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
                .clipped()

            // Bottom gradient to improve text contrast
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.25),
                    Color.black.opacity(0.85)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: height * 0.42) // covers ~40% of the bottom
            .frame(maxWidth: .infinity)
            .blendMode(.normal)

            // Title text
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.bottom, 28)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
    }
}

//MARK: Small card used for channels & apps (compact top10-like size)
struct ChannelCard: View {
    let imageNameOrURL: ChannelImageSource
    let badgeAsset: String?      // optional small platform logo asset name (circle)
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image (either asset or remote)
            Group {
                switch imageNameOrURL {
                case .asset(let name):
                    Image(name)
                        .resizable()
                        .scaledToFill()
                case .url(let url):
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let img):
                            img.resizable().scaledToFill()
                        default:
                            Color.gray.opacity(0.12)
                        }
                    }
                }
            }
            .frame(width: width, height: height)
            .clipped()
            .scaleEffect(1.02)             // slight zoom to hide any poster borders
            .offset(y: -4)                 // lift a bit so bottom blend looks nicer

            // bottom blur + gradient for readability (apple style)
            LinearGradient(
                colors: [ Color.black.opacity(0.0), Color.black.opacity(0.22), Color.black.opacity(0.78) ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: height * 0.38)
            .frame(maxWidth: .infinity)
            .blendMode(.normal)

             // optional badge / platform icon
                if let badge = badgeAsset {
                    HStack {
                        ZStack {

                            // --- FIXED BLACK TILE (never stretches) ---
                            let tileWidth: CGFloat = 125
                            let tileHeight: CGFloat = 88
                            let corner: CGFloat = 18
                            let logoWidth: CGFloat = 65    // change this to increase/decrease logo width
                            let logoHeight: CGFloat = 65   // change this to increase/decrease logo height
                            
                            Rectangle()
                                .fill(Color.black.opacity(0.65))
                                .frame(width: tileWidth, height: tileHeight)
                                .shadow(color: Color.black.opacity(0.6), radius: 10, y: 4)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                                )
                                .padding(.bottom, -100)
                                .padding(.top, 10)
                            
                            // subtle glow
                            RoundedRectangle(cornerRadius: corner)
                                .fill(Color.white.opacity(0.03))
                                .blur(radius: 10)
                                .frame(width: tileWidth, height: tileHeight)
                            

                            // --- LOGO (independent sizing) ---
                            Image(badge)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: logoWidth, height: logoHeight)
                                .padding(.all, 4)
                                .padding(.bottom, -80)
                                .padding(.top, 20)

                        }
                        .padding(.leading, 10)
                        

                        Spacer()
                    }
                    .padding(.bottom, height * 0.28)
                }
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.04), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.45), radius: 10, y: 6)
    }
}

enum ChannelImageSource {
    case asset(String)
    case url(URL)
}

// MARK: - Account Bottom Sheet
struct AccountBottomSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var autoPlayNextEpisode = true
    @State private var autoPlayRecommendation = true
    @State private var syncSports = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Black")
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Profile Section
                        Button {
                            // Navigate to profile detail
                        } label: {
                            HStack(spacing: 15) {
                                Image("sameer")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sameer Nikhil")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("adrenox123@gmail.com")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color("Grey"))
                            .cornerRadius(25)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Sources Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Sources")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading, 25)
                                .padding(.top, 25)
                            
                            Button {
                                // Navigate to connected apps
                            } label: {
                                HStack {
                                    Text("Connected Apps")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("0")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color("Grey"))
                                .cornerRadius(25)
                            }
                            .padding(.horizontal)
                        }
                        
                        // Account Actions Section
                        VStack(spacing: 0) {
                            AccountButton(title: "Manage Subscriptions", icon: nil)
                            AccountButton(title: "Redeem Gift Card or Code", icon: nil)
                            AccountButton(title: "Add Money to Account", icon: nil)
                        }
                        .background(Color("Grey"))
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.top, 25)
                       
                        
                        // Clear Play History
                        VStack(spacing: 8) {
                            Button {
                                // Clear history action
                            } label: {
                                Text("Clear Play History")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("Grey"))
                                    .cornerRadius(25)
                            }
                            .padding(.horizontal)
                            
                            Text("Clear what you've watched from your devices.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading, -70)
                        }
                        .padding(.top, 25)
                        
                        // Auto-Play Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Auto-Play")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading, 25)
                                .padding(.top, 25)
                            
                           VStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    Toggle(isOn: $autoPlayNextEpisode) {
                                        Text("Play Next Episode")
                                            .font(.body)
                                            .foregroundColor(.white)
                                    }
                                    .tint(.green)
                                    .padding()
                                    
                                    Divider()
                                        .frame(height: 1)
                                        .overlay(Color.white.opacity(0.1))
                                        .padding(.horizontal, 16)
                                    
                                    Toggle(isOn: $autoPlayRecommendation) {
                                        Text("Play a Recommendation")
                                            .font(.body)
                                            .foregroundColor(.white)
                                    }
                                    .tint(.green)
                                    .padding()
                                }
                                .background(Color("Grey"))
                                .cornerRadius(25)
                            }
                            .padding(.horizontal)
                          
                            
                            Text("At the end of an episode, automatically play the next one. After a series, movie, or sporting event, automatically play content recommended for you.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 5)
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Sports")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading, 25)
                                .padding(.top, 25)
                            
                            VStack(spacing: 15) {
                                Toggle(isOn: $syncSports) {
                                    Text("Sync My Sports")
                                        .font(.body)
                                        .foregroundColor(.white)
                                }
                                .tint(.green)
                                .padding()
                                .background(Color("Grey"))
                                .cornerRadius(25)
                            }
                            .padding(.horizontal)
                            
                            Text("Sports, leagues, teams, and athletes you follow will sync across Apple News, Apple TV, and other Apple apps. See how your data is managed...")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 5)
                        }
                        
                        VStack(spacing: 8) {
                            Button {
                                // Clear history action
                            } label: {
                                Text("Sign Out")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("Grey"))
                                    .cornerRadius(25)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 25)
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Account")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

// MARK: - Account Button Helper
struct AccountButton: View {
    let title: String
    let icon: String?
    var showDivider: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                // Action
            } label: {
                HStack {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    Text(title)
                        .font(.body)
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding()
                .contentShape(Rectangle())
            }
            
            if showDivider {
                Divider()
                    .frame(height: 1)
                    .overlay(Color.white.opacity(0.1))
                    .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - View Model
class HomeViewModel: ObservableObject {
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
    
     // MARK: - Fetch YouTube Trailer URL 
     func fetchYouTubeTrailerURL(
        for content: MediaContent,
        completion: @escaping (URL?) -> Void
    ) {
        // Apple TV app is movie-first
        let mediaType = "movie"

        let urlString =
        "https://api.themoviedb.org/3/\(mediaType)/\(content.id)/videos?api_key=\(apiKey)"

        print("🎬 Fetching trailer:", urlString)

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                print("❌ No data from TMDB")
                completion(nil)
                return
            }

            do {
                let response = try JSONDecoder().decode(TMDBVideoResponse.self, from: data)

                print("🎞️ TMDB videos:", response.results)

                let trailer = response.results.first {
                    $0.site == "YouTube" && $0.type == "Trailer"
                }

                guard let key = trailer?.key else {
                    print("❌ No YouTube trailer found")
                    completion(nil)
                    return
                }

                print("✅ Trailer key:", key)

                let embedURL = URL(string: "https://www.youtube.com/embed/\(key)")
                completion(embedURL)

            } catch {
                print("❌ Decode error:", error)
                completion(nil)
            }
        }
        .resume()
    }
    
  func extractYouTubeID(from url: String) -> String? {
        
        // watch?v=
        if let range = url.range(of: "v=") {
            return String(url[range.upperBound...]).components(separatedBy: "&").first
        }

        // youtu.be/
        if url.contains("youtu.be/") {
            return url.components(separatedBy: "youtu.be/").last
        }

        // embed/
        if url.contains("/embed/") {
            return url.components(separatedBy: "/embed/").last
        }

        return nil
    }
    
    //MARK: Returns multiple trailers if one plays stops trying for other
      func fetchEmbeddableTrailerKeys(
        for movieID: Int,
        completion: @escaping ([String]) -> Void
    ) {
        let urlString =
        "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let data,
                let response = try? JSONDecoder().decode(TMDBVideoResponse.self, from: data)
            else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            let preferredTypes = ["Teaser", "Clip", "Trailer"]

            let keys = preferredTypes.flatMap { type in
                response.results
                    .filter { $0.site == "YouTube" && $0.type == type }
                    .map { $0.key }
            }

            DispatchQueue.main.async {
                completion(keys)
            }
        }.resume()
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
            
            // ✅ DEBUG: Print raw response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("🔍 Raw API Response: \(jsonString)")
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
    
    // MARK: - Setup Your Custom Movies Here
    func setupCustomMovies() {
        //MARK: Featured Movies (for hero carousel)
        featuredContent = [
            MovieBuilder()
                .id(911430)
                .posterPath("/f8JoxzIUzha3m9td6NcmFtuW80C.jpg")
                .backdropPath("/vN56KYeuW4eAci0Rllp36IGPvSo.jpg")
                .trailerKey("uYPbbksJxIg")
                .build(),
            
            MovieBuilder()
                .id(1363123)
                .posterPath("/qJ2tW6WMUDux911r6m7haRef0WH.jpg")
                .backdropPath("/jW8zNXFcRdHCyruUnnkBoEuDV4a.jpg")
                .trailerKey("d9MyW72ELq0")
                .build(),
            
            MovieBuilder()
                .id(1511417)
                .posterPath("/cVxVGwHce6xnW8UaVUggaPXbmoE.jpg")
                .backdropPath("/yOv2boj3ALoEEDtRteL7vhmRyG.jpg")
                .build(),
            
            MovieBuilder()
                .id(1726)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")
                .build(),
            
            MovieBuilder()
                .id(877817)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/hshaRU2AmeuXB7ttaebJHsuTVRC.jpg")
                .build(),
            
            MovieBuilder()
                .id(22)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/9LLUQBaIUIhSnl9y01WrvNFRzl0.jpg")
                .build(),
            
            MovieBuilder()
                .id(868759)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/uJRQc61mh5hgj0wHLpRclb3oMYM.jpg")
                .build(),
            
            MovieBuilder()
                .id(980489)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/bGiNbWaWQxuyIeuajujvsQRJw9y.jpg")
                .build(),
            
            MovieBuilder()
                .id(58574)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/ymbeuAFMQwAMUMh4MRdJHunu9jq.jpg")
                .build(),
            
            MovieBuilder()
                .id(37724)
                .posterPath("/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
                .backdropPath("/pXPNgL2tLRDHU3twDhebAxO9Xic.jpg")
                .build()
        ]
        
        //MARK: Continue Watching
        continueWatching = [
            MovieBuilder()
                .id(11)
                .title("Invasion")
                .posterPath("/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
                .backdropPath("/uPn5LWCLUKII5BFBkJoLqXYcGN3.jpg")
                .overview("Paul Atreides arrives on the most dangerous planet")
                .rating(8.0)
                .build(),
            
            MovieBuilder()
                .id(12)
                .title("Hijack")
                .posterPath("/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
                .backdropPath("/kfua5A0ZUHRRf1UxiQeoIVlkfSI.jpg")
                .overview("Spider-Man's identity is revealed")
                .rating(8.2)
                .build(),
            
            MovieBuilder()
                .id(13)
                .title("Defending Jacob")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/A84Udi14ewFd6jw1sN3ziWeRS2R.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
            //
            MovieBuilder()
                .id(14)
                .title("Rush")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/D3eDUNEzJPBDG3TCJcR7RyRgTA.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(15)
                .title("Oppenheimer")
                .posterPath("/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg")
                .backdropPath("/cUIqZd6jJCbO94Txt1CkTs7MSeP.jpg")
                .overview("A paraplegic Marine dispatched to the moon Pandora")
                .rating(7.9)
                .build(),
        ]
        
        //MARK: My Favorites
        myFavorites = [
            MovieBuilder()
                .id(16)
                .posterPath("/5TEwh75PYCDQaOXngknP62rpVrg.jpg")
                .backdropPath("/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")
                .overview("Two imprisoned men bond over a number of years")
                .rating(9.3)
                .build(),
            
            MovieBuilder()
                .id(17)
                .posterPath("/pWbGVx1vHyJR2s5aXRe52od3d1j.jpg")
                .backdropPath("/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg")
                .overview("The lives of two mob hitmen, a boxer, and more")
                .rating(8.9)
                .build(),
            
            MovieBuilder()
                .id(18)
                .posterPath("/mI8uqf7QtHUheYn4DwGFtEADsFR.jpg")
                .backdropPath("/mI8uqf7QtHUheYn4DwGFtEADsFR.jpg")
                .overview("The presidencies of Kennedy and Johnson unfold")
                .rating(8.8)
                .build(),
            
            MovieBuilder()
                .id(19)
                .posterPath("/q7DYn33bg4D1wsIleKfftxWjBHS.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(20)
                .posterPath("/jmJ8SiY8AgtuXKiit0bnGxOpYvL.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(21)
                .posterPath("/ir0LVEVD74XjdAY4f6mR40hv0b.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(22)
                .posterPath("/w5O3VVeG3jIR62IVbNMvFKY0p1Q.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(23)
                .posterPath("/nNezPNloEslI3FYE4c1K3CxvV9g.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(24)
                .posterPath("/9Sn2CmRh87RgUeglqsHNH863V4E.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build(),
            
            MovieBuilder()
                .id(25)
                .posterPath("/nuGNcV2ewc51nVg4c7of0tEe6he.jpg")
                .backdropPath("/icmmSD4vTTDKOq2vvdulafOGw93.jpg")
                .overview("A computer hacker learns about the true nature of reality")
                .rating(8.7)
                .build()
        ]
        
        //MARK: Custom Row 1
        myCustomRow1 = [
            MovieBuilder()
                .id(26)
                .posterPath("/zd8IdEEUjydSsYhLHuu9jvNwvzA.jpg")
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
                .title("The Family Plan 2")
                .posterPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .backdropPath("/nPJhaexTEfvQEvVgO8zjrs1AEqP.jpg")
                .overview("Mark Wahlberg's assassin past threatens to derail his family's festive holiday.")
                .rating(8.4)
                .build(),
            
            MovieBuilder()
                .id(37)
                .title("Fountain Of Youth")
                .posterPath("/uxzzxijgPIY7slzFvMotPv8wjKA.jpg")
                .backdropPath("/fH23vaBWyAHAzLcCgzteCkGpSHk.jpg")
                .overview("Treasure-hunting siblings reunite for a life-changing adventure.")
                .rating(7.3)
                .build(),
            
            MovieBuilder()
                .id(38)
                .title("The Last Thing He Told Me")
                .posterPath("/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")
                .backdropPath("/iNWwoztNhatbdJgt00dpLaDhtK1.jpg")
                .overview("Jennifer Garner stars as a wife looking for answers after her husband disappears.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(39)
                .title("The Family Plan")
                .posterPath("/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")
                .backdropPath("/mjIAPxcIrsiy7zt2fFGvPiMiDUO.jpg")
                .overview("Mark Wahlberg's stars as an assassin-turned-dad on a road trip to save his family.")
                .rating(7.9)
                .build(),
            
            MovieBuilder()
                .id(40)
                .title("The Mosquito Coast")
                .posterPath("/78lPtwv72eTNqFW9COBYI0dWDJa.jpg")
                .backdropPath("/kbR4hHZZfrDEMkZgX8NIZwvqCut.jpg")
                .overview("Justin Theroux is a father who uproots his family for a dangerous quest.")
                .rating(7.9)
                .build()
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

// MARK: - Movie Builder (Helper for easy movie creation)
class MovieBuilder {
    private var movieId: Int = 0
    private var movieTitle: String = ""
    private var moviePosterPath: String = ""
    private var movieBackdropPath: String = ""
    private var movieOverview: String = ""
    private var movieRating: Double = 0.0
    private var youtubeTrailerURL: String?
    private var movieTrailerKey: String?
    
    func id(_ id: Int) -> MovieBuilder {
        self.movieId = id
        return self
    }
    
    func title(_ title: String) -> MovieBuilder {
        self.movieTitle = title
        return self
    }
    
    func posterPath(_ path: String) -> MovieBuilder {
        self.moviePosterPath = path
        return self
    }
    
    func backdropPath(_ path: String) -> MovieBuilder {
        self.movieBackdropPath = path
        return self
    }
    
    func overview(_ overview: String) -> MovieBuilder {
        self.movieOverview = overview
        return self
    }
    
    func rating(_ rating: Double) -> MovieBuilder {
        self.movieRating = rating
        return self
    }
    
    func youtubeTrailer(_ url: String) -> MovieBuilder {
        self.youtubeTrailerURL = url
        return self
    }
    
    func trailerKey(_ key: String) -> MovieBuilder {
        self.movieTrailerKey = key
        return self
    }
    
    func build() -> MediaContent {
        return MediaContent(
            id: movieId,
            title: movieTitle,
            name: nil,
            overview: movieOverview,
            posterPath: moviePosterPath,
            backdropPath: movieBackdropPath,
            voteAverage: movieRating,
            releaseDate: "2024",
            youtubeTrailerURL: youtubeTrailerURL,
            trailerKey: movieTrailerKey
        )
    }
}

// MARK: - Models
struct TMDBResponse: Codable {
    let results: [MediaContent]
}

// MARK: - TMDB Video Models
struct TMDBVideoResponse: Decodable {
    let results: [TMDBVideo]
}

struct TMDBVideo: Codable, Identifiable {
    let id: String
    let key: String
    let site: String
    let type: String
}

 struct MediaContent: Codable, Identifiable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let releaseDate: String?
    let trailerKey: String?
    let youtubeTrailerURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        // ⚠️ DON'T include trailerKey or youtubeTrailerURL here
        // These are manual-only fields
    }

    // ✅ FIXED DECODER - doesn't touch manual fields
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)

        // 🔑 These are NEVER decoded from TMDB JSON
        youtubeTrailerURL = nil
        trailerKey = nil
    }

    // ✅ Manual initializer (MovieBuilder uses this)
    init(
        id: Int,
        title: String?,
        name: String?,
        overview: String?,
        posterPath: String?,
        backdropPath: String?,
        voteAverage: Double?,
        releaseDate: String?,
        youtubeTrailerURL: String? = nil,
        trailerKey: String? = nil
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.youtubeTrailerURL = youtubeTrailerURL
        self.trailerKey = trailerKey
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .preferredColorScheme(.dark)
}

//#Preview {
//    TrailerPlayerView(videoID: "dQw4w9WgXcQ")
//}


private extension UIImage {
    func averageColor(resizeTo size: CGSize = CGSize(width: 8, height: 8)) -> UIColor? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        draw(in: CGRect(origin: .zero, size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = img?.cgImage,
              let data = cgImage.dataProvider?.data,
              let ptr = CFDataGetBytePtr(data)
        else { return nil }

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        let length = CFDataGetLength(data)
        let count = length / 4

        for i in stride(from: 0, to: length, by: 4) {
            r += CGFloat(ptr[i])
            g += CGFloat(ptr[i + 1])
            b += CGFloat(ptr[i + 2])
        }

        return UIColor(
            red: (r / CGFloat(count)) / 255,
            green: (g / CGFloat(count)) / 255,
            blue: (b / CGFloat(count)) / 255,
            alpha: 1
        )
    }
}


//MARK: IMPORTANT
//One user tap → one network call → one state update
//Never nest the same async call inside itself.
//@State → ONLY inside Views
//ObservableObject → NO UI state
//⚠️ Important rules
//    •    Function must be inside the struct
//    •    Function must be outside var body
//    •    Marking it private is recommended
