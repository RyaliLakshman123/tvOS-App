//
//  TVApp.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//

import SwiftUI

@main
struct TVApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Wrap TabView inside WindowGroup
                MainTabView()
//                TrailerPlayerView(
//                    videoURL: URL(
//                        string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
//                    )!
//                )
            }
            .navigationViewStyle(.stack)
        }
    }
}

// Separate View for TabView
struct MainTabView: View {
    var body: some View {
        TabView {
            // First Tab - List View
            NavigationView {
               HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            // Second Tab - Settings
            NavigationView {
                AppleTVView()
            }
            .tabItem {
                Label("Apple TV", systemImage: "appletv.fill")
            }

            // Third Tab - Profile
            NavigationView {
                StoreView()
            }
            .tabItem {
                Label("Store", systemImage: "bag.fill")
            }

            // Fourth Tab - Search
            NavigationView {
                LibraryView()
            }
            .tabItem {
                Label("Library", systemImage: "rectangle.stack.fill")
            }

            // Fifth Tab - Search (Separate)
            SearchTabView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

// Separate Search Tab View
struct SearchTabView: View {
    var body: some View {
        NavigationView {
            SearchView()
        }
    }
}
