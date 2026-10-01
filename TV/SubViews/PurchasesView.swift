//
//  PurchasesView.swift
//  TV
//
//  Created by Sameer Nikhil on 05/01/26.
//

import SwiftUI

struct PurchasesView: View {

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 14) {

                Spacer()

                Text("Your Library Is Empty")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("TV shows and movies you purchase from the Store will appear here.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()
            }
        }
        .navigationTitle("Purchases")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    PurchasesView()
}
