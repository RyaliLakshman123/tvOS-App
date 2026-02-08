//
//  SearchCategoryCard.swift
//  TV
//
//  Created by Sameer Nikhil on 05/01/26.
//

import SwiftUI

struct SearchCategoryCard: View {

    let category: SearchCategory

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 18))
//                .overlay(
//                    LinearGradient(
//                        colors: [.clear, .black.opacity(0.7)],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
                .clipped()

            Text(category.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(12)
        }
    }
}

//MARK: Model
struct SearchCategory: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        SearchCategoryCard(category: SearchCategory(title: "Action", image: "f1-Brad"))
    }
}
