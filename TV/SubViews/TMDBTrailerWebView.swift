//
//  YouTubePlayerView.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//


import SwiftUI
import WebKit

struct TMDBTrailerWebView: UIViewRepresentable {
    let videoKey: String
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // ✅ DIRECT YOUTUBE URL - No iframe, no policies to block!
        let youtubeURL = "https://www.youtube.com/embed/\(videoKey)?playsinline=1&autoplay=1&controls=1&rel=0&modestbranding=1&fs=1"
        
        if let url = URL(string: youtubeURL) {
            let request = URLRequest(url: url)
            webView.load(request)
            print("✅ Loading YouTube URL: \(youtubeURL)")
        }
    }
}

