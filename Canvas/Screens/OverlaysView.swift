//
//  OverlaysView.swift
//  Canvas
//
//  Created by Danilo Henrique on 05/02/25.
//

import SwiftUI

struct OverlaysView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    let images = [
        "star.fill", "heart.fill", "camera.fill", "bell.fill", "airplane", "cloud.fill", "leaf.fill", "moon.fill"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(images, id: \.self) { image in
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Overlays")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OverlaysView()
    }
}
