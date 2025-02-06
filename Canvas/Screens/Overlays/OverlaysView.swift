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
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.imagesURL, id: \.self) { imageURL in
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 87, height: 130)
                                            .foregroundStyle(.white)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 87, height: 130)
                                            .padding()
                                            .cornerRadius(10)
                                    default:
                                        Image(systemName: "x.circle.fill")
                                    }
                                }
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
        .alert("Error fetching data", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OverlaysView()
    }
}
