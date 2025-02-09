//
//  OverlaysView.swift
//  Canvas
//
//  Created by Danilo Henrique on 05/02/25.
//

import SwiftUI

struct OverlaysView: View {
    
    @Binding var selectedImages: [CanvasImage]
    @StateObject private var viewModel = OverlaysViewModel(service: OverlaysService())
    @Environment(\.dismiss) var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                ScrollView {
                    LazyVGrid(columns: columns) {
                        if viewModel.isLoading {
                            ForEach(0..<15) { _ in
                                ProgressIndicator()
                            }
                        } else {
                            ForEach(viewModel.imagesURL, id: \.self) { imageURL in
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressIndicator()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(width: 87, height: 130)
                                            .padding()
                                            .onTapGesture {
                                                selectedImages.append(.init(url: imageURL))
                                                dismiss()
                                            }
                                    default:
                                        Image(systemName: "x.circle.fill")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Overlays")
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    DismissButton()
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
        OverlaysView(selectedImages: .constant([]))
    }
}
