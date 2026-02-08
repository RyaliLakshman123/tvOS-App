//
//  SearchView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//


import SwiftUI

struct SearchView: View {

    @State private var showAccountSheet = false
    @State private var searchText: String = ""
    @State private var isSearching = false
    
    // MARK: - Grid Layout
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // MARK: - Categories (Image name must exist in Assets)
    private let categories: [SearchCategory] = [
        .init(title: "Apple TV+", image: "f1-Brad"),
        .init(title: "Season Pass", image: "messi"),
        .init(title: "Bollywood", image: "war"),

        .init(title: "Regional Indian", image: "kaththi"),
        .init(title: "Action", image: "extraction"),
        .init(title: "Adventure", image: "pirates"),

        .init(title: "Comedy", image: "3 idiots"),
        .init(title: "Drama", image: "777"),
        .init(title: "Horror", image: "gruham"),

        .init(title: "Romance", image: "chennai express"),
        .init(title: "Kids & Family", image: "scooby"),
        .init(title: "Sci-Fi", image: "matrix"),
        
        .init(title: "Thriller", image: "now u see mee"),
        .init(title: "Classics", image: "madmax"),
        .init(title: "Fantasy", image: "blade"),

        .init(title: "Animation", image: "me 4"),
        .init(title: "Documentary", image: "lemans"),
        .init(title: "Independent", image: "daybreakers"),
        
        .init(title: "Music", image: "this is it"),
        .init(title: "Short Films", image: "sardaar"),
        .init(title: "Western", image: "django")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories) { category in
                        SearchCategoryCard(category: category)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 80) // avoids tab bar overlap
            }
        }
        // MARK: - Toolbar (Same as Library)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {
                Text("Search")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .fixedSize()
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAccountSheet = true
                } label: {
                    Image("sameer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 60)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        // the below toolbackground with color.black will give u a black background at the top 
//        .toolbarBackground(Color.black, for: .navigationBar)
        .sheet(isPresented: $showAccountSheet) {
            AccountBottomSheet()
        }
    }
}

#Preview {
    SearchView()
}

