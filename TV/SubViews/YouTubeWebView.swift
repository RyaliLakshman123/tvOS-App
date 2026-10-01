//
//  YouTubeWebView.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    let videoID: String
    let onError: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onError: onError)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.allowsPictureInPictureMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.backgroundColor = .black
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100%;
                background: black;
                overflow: hidden;
            }
            iframe {
                width: 100vw;
                height: 100vh;
                border: none;
            }
        </style>
        </head>
        <body>
            <iframe
                src="https://www.youtube-nocookie.com/embed/\(videoID)?playsinline=1&autoplay=1&controls=1&rel=0"
                allow="autoplay; encrypted-media; picture-in-picture"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """

        webView.loadHTMLString(
            html,
            baseURL: URL(string: "https://www.youtube.com")
        )
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let onError: () -> Void

        init(onError: @escaping () -> Void) {
            self.onError = onError
        }

        func webView(_ webView: WKWebView,
                     didFail navigation: WKNavigation!,
                     withError error: Error) {
            onError()
        }

        func webView(_ webView: WKWebView,
                     didFailProvisionalNavigation navigation: WKNavigation!,
                     withError error: Error) {
            onError()
        }
    }
}
