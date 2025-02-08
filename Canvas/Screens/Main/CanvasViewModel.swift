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
    
    // MARK: Properties
    
    @Published var images: [CanvasImage] = [
        .init(image: UIImage(named: "bee")!, position: .init(x: 100, y: 100)),
        .init(image: UIImage(named: "bee")!, position: .init(x: 200, y: 100))
    ]
    
    // MARK: Public Functions
    
    func updatePosition(by location: CGPoint, for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].position = location
            }
        }
    }
    
    func update(scale: CGFloat, for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].scale = scale
            }
        }
    }
    
    func selectImage(for id: UUID) {
        deselectAllImages()
        if let index = images.firstIndex(where: { $0.id == id }) {
            images[index].isSelected = true
        }
    }
    
    func deselectAllImages() {
        for index in images.indices {
            images[index].isSelected = false
        }
    }
}
