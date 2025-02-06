//
//  OverlaysView.swift
//  Canvas
//
//  Created by Danilo Henrique on 05/02/25.
//

import SwiftUI

struct OverlaysView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = OverlaysViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Fetching Images")
                    .progressViewStyle(.circular)
            } else {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.images, id: \.self) { image in
                                Image(systemName: image)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
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
        .onAppear {
            viewModel.fetchImages()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OverlaysView()
    }
}
