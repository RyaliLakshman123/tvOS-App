//
//  SearchView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//


//
//  Search tab: type to search TMDB, or tap a category to browse it.
//  Every result opens the correct detail screen via MediaDetailLink.
//

import SwiftUI

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()
    @State private var showAccountSheet = false
    @FocusState private var searchFocused: Bool

    // MARK: - Grid Layout
    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    private let resultColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
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

    private var isSearchingText: Bool {
        !viewModel.query.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                searchBar

                if isSearchingText {
                    searchResults
                } else {
                    categoryGrid
                }
            }
        }
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
        .sheet(isPresented: $showAccountSheet) {
            AccountBottomSheet()
        }
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.6))

            TextField("", text: $viewModel.query, prompt:
                Text("Movies, TV Shows and More").foregroundColor(.white.opacity(0.5))
            )
            .foregroundColor(.white)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .focused($searchFocused)
            .submitLabel(.search)
            .onChange(of: viewModel.query) { _, newValue in
                viewModel.search(newValue)
            }

            if isSearchingText {
                Button {
                    viewModel.query = ""
                    viewModel.search("")
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.5))
                }
            }
        }
        .padding(.horizontal, 14)
        .frame(height: 44)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.08), lineWidth: 1))
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 10)
    }

    // MARK: - Category grid (default)

    private var categoryGrid: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(categories) { category in
                    NavigationLink {
                        CategoryResultsView(category: category)
                    } label: {
                        SearchCategoryCard(category: category)
                    }
                    .buttonStyle(CardPressStyle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom, 80)
        }
    }

    // MARK: - Text search results

    private var searchResults: some View {
        Group {
            if viewModel.isLoading && viewModel.results.isEmpty {
                Spacer()
                ProgressView().tint(.white)
                Spacer()
            } else if viewModel.results.isEmpty {
                Spacer()
                VStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 36))
                        .foregroundColor(.white.opacity(0.3))
                    Text("No results for \"\(viewModel.query)\"")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: resultColumns, spacing: 16) {
                        ForEach(viewModel.results) { item in
                            SearchResultCard(content: item)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Category results screen

struct CategoryResultsView: View {
    let category: SearchCategory
    @StateObject private var viewModel = SearchViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.isLoading && viewModel.results.isEmpty {
                ProgressView().tint(.white)
            } else if viewModel.results.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "film")
                        .font(.system(size: 36))
                        .foregroundColor(.white.opacity(0.3))
                    Text("Nothing to show here yet.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.results) { item in
                            SearchResultCard(content: item)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    .padding(.bottom, 80)
                }
            }
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .task { viewModel.loadCategory(category) }
    }
}

// MARK: - Result poster card (opens correct detail screen)

struct SearchResultCard: View {
    let content: MediaContent

    var body: some View {
        MediaDetailLink(content: content) {
            VStack(alignment: .leading, spacing: 6) {
                Color(white: 0.14)
                    .aspectRatio(2.0/3.0, contentMode: .fit)
                    .overlay {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342\(content.posterPath ?? content.backdropPath ?? "")")) { phase in
                            if case .success(let image) = phase {
                                image.resizable().scaledToFill()
                            } else {
                                Image(systemName: "film")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white.opacity(0.25))
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.08), lineWidth: 1))

                Text(content.title ?? content.name ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
    .preferredColorScheme(.dark)
}
