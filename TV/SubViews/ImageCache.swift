//
//  ImageCache.swift
//  TV
//
//  Created by Sameer Nikhil on 13/12/25.
//

import SwiftUI
import Combine

// MARK: - ImageCache Singleton
class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

// MARK: - Image Loader (Checks cache first)
class CachedImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
        loadImage()
    }

    deinit {
        cancellable?.cancel()
    }

    private func loadImage() {
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { img in
                if let img = img {
                    ImageCache.shared.setObject(img, forKey: self.url as NSURL)
                }
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
}

struct CachedAsyncImage: View {
    @StateObject private var loader: CachedImageLoader
    let url: URL

    init(url: URL) {
        _loader = StateObject(wrappedValue: CachedImageLoader(url: url))
        self.url = url
    }

    var body: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()        // <- ALWAYS RESIZABLE HERE
                    .scaledToFill()
            } else {
                // Placeholder (also resizable)
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.3)
            }
        }
    }
}
