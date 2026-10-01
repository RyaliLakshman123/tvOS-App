//
//  LibraryView.swift
//  TV
//
//  Created by Sameer Nikhil on 07/12/25.
//


import SwiftUI

struct LibraryView: View {

    @State private var showAccountSheet = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                VStack(spacing: 0) {

                    NavigationLink {
                        PurchasesView()
                    } label: {
                        libraryRow(icon: "tag", title: "Purchases")
                    }

                    Divider()
                        .background(Color.white.opacity(0.2))
                        .padding(.leading, 56)

                    NavigationLink {
                        FamilySharingView()
                    } label: {
                        libraryRow(icon: "person.2", title: "Family Sharing")
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Library")
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
        .toolbarBackground(Color.black, for: .navigationBar)
        .sheet(isPresented: $showAccountSheet) {
            AccountBottomSheet()
        }
    }

    // MARK: - Row UI
    private func libraryRow(icon: String, title: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 28)

            Text(title)
                .font(.title3)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(.vertical, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        LibraryView()
    }
}
