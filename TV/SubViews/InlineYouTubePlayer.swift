//
//  InlineYouTubePlayer.swift
//  TV
//
//  Created by Sameer Nikhil on 16/12/25.
//

import SwiftUI
import WebKit

struct InlineYouTubePlayer: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <!DOCTYPE html>
        <html>
        <body style="margin:0;background:black;">
        <iframe
            width="100%"
            height="100%"
            src="https://www.youtube.com/embed/\(videoID)?playsinline=1&autoplay=1&controls=1&modestbranding=1&rel=0"
            frameborder="0"
            allow="autoplay; fullscreen"
            allowfullscreen>
        </iframe>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}

