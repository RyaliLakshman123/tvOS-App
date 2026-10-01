//
//  TrailerPlayerView.swift
//  TV
//
//  Created by Sameer Nikhil on 15/12/25.
//

import SwiftUI
import SafariServices
import AVFoundation

struct TrailerPlayerView: View {
    let videoKey: String
    let movieTitle: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SafariView(url: URL(string: "https://www.youtube.com/watch?v=\(videoKey)")!, dismiss: dismiss)
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .statusBarHidden(false)
            .onAppear {
                configureAudioSession()
            }
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let dismiss: DismissAction
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        config.barCollapsingEnabled = true
        
        let safari = SFSafariViewController(url: url, configuration: config)
        safari.preferredBarTintColor = .black
        safari.preferredControlTintColor = .white
        safari.dismissButtonStyle = .done
        safari.delegate = context.coordinator
        
        return safari
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let dismiss: DismissAction
        
        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            dismiss()
        }
    }
}
//MARK: you can check whether the audio and video are working by this view
