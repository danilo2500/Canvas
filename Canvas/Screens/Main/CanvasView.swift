//
//  MainView.swift
//  Canvas
//
//  Created by Danilo Henrique on 03/02/25.
//

import SwiftUI

struct CanvasView: View {
    
    @StateObject private var viewModel = CanvasViewModel()
    
    @State private var showOverlaySheet = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                VStack {
                    Spacer()
                        ZStack {
                            GeometryReader { proxy in
                                let canvasSize = proxy.size
                                Color.white
                                    .edgesIgnoringSafeArea(.all)
                                    .onTapGesture {
                                        viewModel.deselectAllImages()
                                    }
                                ForEach(viewModel.snapLines) { snapLine in
                                    switch snapLine.orientation {
                                    case .horizontal(let yPosition):
                                        Rectangle()
                                            .fill(Color.yellow)
                                            .frame(width: canvasSize.width, height: 1)
                                            .position(x: canvasSize.width / 2, y: yPosition)
                                    case .vertical(let xPosition):
                                        Rectangle()
                                            .fill(Color.yellow)
                                            .frame(width: 1, height: canvasSize.height)
                                            .position(x: xPosition, y: canvasSize.height / 2)
                                    }
                                }
                                ForEach(viewModel.images) { canvasImage in
                                    AsyncImage(url: canvasImage.url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressIndicator()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(canvasImage.scale)
                                                .cornerRadius(10)
                                                .saturation(canvasImage.isSelected ? 0.0 : 1.0)
                                                .frame(width: canvasImage.size.width, height: canvasImage.size.height)
                                                .border(canvasImage.isSelected ? .blue : .clear)
                                                .position(canvasImage.position)
                                                .onTapGesture {
                                                    viewModel.selectImage(for: canvasImage.id)
                                                }
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged { gesture in
                                                            viewModel.updatePosition(by: gesture.location, for: canvasImage.id, canvasSize: canvasSize)
                                                        }
                                                        .onEnded({ _ in
                                                            viewModel.removeAllSnapLines()
                                                        })
                                                )
                                                .gesture(
                                                    MagnificationGesture()
                                                        .onChanged { scale in
                                                            viewModel.update(scale: scale, for: canvasImage.id)
                                                        }
                                                )
                                        default:
                                            Image(systemName: "x.circle.fill")
                                        }
                                    }
                                }
                            }
                            .clipped()
                        }
                        .frame(height: 300)
                    Spacer()
                }
                TabView(showOverlaySheet: $showOverlaySheet)
                    .padding(.bottom)
            }
        }
        .sheet(isPresented: $showOverlaySheet) {
            OverlaysView(selectedImages: $viewModel.images)
        }
    }
}

struct TabView: View {
    @Binding var showOverlaySheet: Bool
    
    var body: some View {
        VStack {
            Divider()
                .overlay(.white)
            HStack {
                Spacer()
                Button(action: {
                    showOverlaySheet.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                .padding()
                Spacer()
            }
        }
        .frame(height: 80)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
