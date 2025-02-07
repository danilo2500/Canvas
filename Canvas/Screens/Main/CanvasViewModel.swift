//
//  MainViewModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 07/02/25.
//

import SwiftUI

struct CanvasImage: Identifiable {
    let id = UUID()
    var image: UIImage
    var position: CGPoint
    var isSelected: Bool = false
}

class CanvasViewModel: ObservableObject {
    @Published var images: [CanvasImage] = [
        .init(image: UIImage(systemName: "photo")!, position: .init(x: 100, y: 100))
    ]
}
