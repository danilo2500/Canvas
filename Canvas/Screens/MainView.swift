//
//  MainView.swift
//  Canvas
//
//  Created by Danilo Henrique on 03/02/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 200)
                    Spacer()
                }
                Toolbar()
                    .padding(.bottom)
            }
        }
    }
}

struct Toolbar: View {
    var body: some View {
        VStack {
            Divider()
                .overlay(.white)
            HStack {
                Spacer()
                Button(action: {
                    print("Plus button tapped")
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
