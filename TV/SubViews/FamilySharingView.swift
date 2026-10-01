//
//  FamilySharingView.swift
//  TV
//
//  Created by Sameer Nikhil on 05/01/26.
//

import SwiftUI

struct FamilySharingView: View {

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {

                familyRow(
                    image: "sameer",
                    name: "Nikhil Ryali"
                )

                familyRow(
                    image: "lakshman",
                    name: "Lakshman Ryali"
                )

                familyRow(
                    image: "sriram",
                    name: "Sriram Ryali"
                )

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)
        }
        .navigationTitle("Family Sharing")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Row
    private func familyRow(image: String, name: String) -> some View {
        HStack(spacing: 16) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 52, height: 52)
                .clipShape(Circle())

            Text(name)
                .font(.title3)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.4))
        }
    }
}

#Preview {
    FamilySharingView()
}
