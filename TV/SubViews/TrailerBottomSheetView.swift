//
//  TrailerPlayerView.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import SwiftUI
import WebKit

struct TrailerBottomSheetView: View {
    let youtubeURL: URL

    var body: some View {
        VStack(spacing: 0) {

            // drag handle
            Capsule()
                .fill(Color.white.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 12)

            WebView(url: youtubeURL)
                .cornerRadius(20)
        }
        .background(Color.black)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        // 🔑 REQUIRED for YouTube playback
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = .black
        webView.isOpaque = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
