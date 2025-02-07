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
    var scale: CGFloat = 1.0
}

class CanvasViewModel: ObservableObject {
    @Published var images: [CanvasImage] = [
        .init(image: UIImage(systemName: "photo")!, position: .init(x: 100, y: 100))
    ]
    
    
    func update(id: UUID, position: CGPoint) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].position = position
        }
    }
    
    func update(id: UUID, scale: CGFloat) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].scale = scale
        }
    }

}
