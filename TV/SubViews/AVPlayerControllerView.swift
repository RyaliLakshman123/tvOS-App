//
//  AVPlayerControllerView.swift
//  TV
//
//  Created by Sameer Nikhil on 17/12/25.
//

import SwiftUI
import AVKit
import AVFoundation

struct AVPlayerControllerView: UIViewControllerRepresentable {

    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)

        let controller = AVPlayerViewController()
        controller.player = player
        controller.videoGravity = .resizeAspect

        player.play()
        return controller
    }

    func updateUIViewController(
        _ uiViewController: AVPlayerViewController,
        context: Context
    ) {}
}
