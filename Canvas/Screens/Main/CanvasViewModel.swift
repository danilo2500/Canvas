//
//  MainViewModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 07/02/25.
//

import SwiftUI

struct CanvasImage: Identifiable {
    let id = UUID()
    var url: URL
    var position: CGPoint = CGPoint(x: 100, y: 130)
    var isSelected: Bool = false
    var scale: CGFloat = 1
    var size: CGSize = CGSize(width: 87, height: 130)
}

class CanvasViewModel: ObservableObject {
    
    // MARK: Private Properties
    
    private let snapThreshold: CGFloat = 20
    
    // MARK: Properties
    
    @Published var images: [CanvasImage] = [
        .init(url: URL(string:"https://images.pexels.com/photos/30567859/pexels-photo-30567859.jpeg?auto=compress&cs=tinysrgb&h=130")!)
    ]
    
    // MARK: Public Functions
    
    func updatePosition(by location: CGPoint, for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].position = location
                snapToGuidelinesIfNeeded(imageToSnap: images[index])
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
    //should snap
    private func snapToGuidelinesIfNeeded(imageToSnap: CanvasImage)  {
        guard let index = images.firstIndex(where: { $0.id == imageToSnap.id }) else { return }
        let rect = calculateRectOfSnappingArea(of: imageToSnap)

        for image in images where imageToSnap.id != image.id {
            let otherRect = calculateRectOfSnappingArea(of: image)
            
            let intersection = rect.intersection(otherRect)
            
            if intersection.width < snapThreshold {
                if otherRect.midX < rect.minX { //Snap to right
                    images[index].position.x += intersection.width
                } else { //Snap to left
                    images[index].position.x -= intersection.width
                }
            }
            if intersection.height < snapThreshold {
                if otherRect.midY < rect.minY { //Snap to top
                    images[index].position.y += intersection.height
                } else { //Snap to bottom
                    images[index].position.y -= intersection.height
                }
            }
        }
    }
    
    private func calculateRectOfSnappingArea(of image: CanvasImage) -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: image.position.x - (image.size.width / 2),
                y: image.position.y - (image.size.height / 2)
            ),
            size: image.size
        )
    }
}
