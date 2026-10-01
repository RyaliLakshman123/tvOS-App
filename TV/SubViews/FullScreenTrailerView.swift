//
//  FullScreenTrailerView.swift
//  TV
//
//  Created by Sameer Nikhil on 01/10/26.
//


//
//  Full-screen YouTube trailer player. Reuses the existing working TMDBTrailerWebView
//  (unmuted, with controls), and offers a "Watch on YouTube" fallback for the rare
//  embeds YouTube refuses to play inline.
//


import SwiftUI

struct FullScreenTrailerView: View {
    let videoKey: String
    let title: String

    var body: some View {
        TrailerPlayerView(
            videoKey: videoKey,
            movieTitle: title
        )
    }
}
