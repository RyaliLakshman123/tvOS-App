//
//  TrailerScreen.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import SwiftUI

struct TrailerScreen: View {

    let videoKey: String
    let onPlaybackFailed: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            YouTubeView(videoID: videoKey)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 34))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                Spacer()

                Button("Try another trailer") {
                    onPlaybackFailed()
                }
                .padding(.bottom, 40)
            }
        }
    }
}
