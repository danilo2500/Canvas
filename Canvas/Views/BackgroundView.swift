//
//  BackgroundView.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ContainerRelativeShape()
            .fill(Color.black)
            .ignoresSafeArea()
    }
}
