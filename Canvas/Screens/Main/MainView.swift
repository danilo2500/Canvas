//
//  MainView.swift
//  Canvas
//
//  Created by Danilo Henrique on 03/02/25.
//

import SwiftUI

struct MainView: View {
    @State private var showOverlaySheet = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.white)
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
        MainView()
    }
}
