//
//  HeroView.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import SwiftUI

struct HeroView: View {

    @StateObject private var viewModel = HeroViewModel()

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // Background
            Color.black.ignoresSafeArea()

            if let movie = viewModel.movie {

                VStack(alignment: .leading, spacing: 16) {

                    // Title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // Overview
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(3)

                    // Buttons (video comes in Step 2)
                    HStack(spacing: 16) {

                        Button {
                            // STEP 2: play trailer
                        } label: {
                            Label("Play Trailer", systemImage: "play.fill")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }

                        Button {
                            // later: add to list
                        } label: {
                            Label("My List", systemImage: "plus")
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .frame(height: 420) // Apple TV hero height
    }
}
