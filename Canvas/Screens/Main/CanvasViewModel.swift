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
        .init(image: UIImage(named: "bee")!, position: .init(x: 100, y: 100)),
        .init(image: UIImage(named: "bee")!, position: .init(x: 200, y: 100))
    ]
    
    
    func update(position: CGPoint) {
        for index in images.indices where images[index].isSelected {
//            images[index].position.
        }
    }
    
    func update(scale: CGFloat) {
        for index in images.indices where images[index].isSelected {
            images[index].scale = scale
        }
    }
    
    func toggleSelection(for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].isSelected.toggle()
        }
    }
    
    
    
    func deselectImages() {
        for index in images.indices {
            images[index].isSelected = false
        }
    }
}
