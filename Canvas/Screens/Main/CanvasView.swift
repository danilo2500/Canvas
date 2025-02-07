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
                        Color.white
                            .edgesIgnoringSafeArea(.all)
                        ForEach(viewModel.images) { image in
                            Image(uiImage: image.image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 87, height: 130)
                                .position(.init(x: 100, y: 100))
                        }
                    }
                    .frame(height: 200)
                    Spacer()
                }
                TabView(showOverlaySheet: $showOverlaySheet)
                    .padding(.bottom)
            }
        }
        .sheet(isPresented: $showOverlaySheet) {
            OverlaysView()
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
