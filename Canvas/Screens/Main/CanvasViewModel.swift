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
    var width: CGFloat
    var height: CGFloat
    
    var rect: CGRect {
        CGRect(origin: position, size: CGSize(width: width * scale, height: height * scale))
    }
}

class CanvasViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var images: [CanvasImage] = [
        .init(image:  UIImage(named: "bee")!, position: .init(x: 0, y: 0), width: 50, height: 50),
        .init(image:  UIImage(named: "bee")!, position: .init(x: 100, y: 100), width: 50, height: 50),
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
    private func snapToGuidelinesIfNeeded(imageToSnap: CanvasImage) -> CGPoint {
        guard let index = images.firstIndex(where: { $0.id == imageToSnap.id }) else { return .zero }

        var point = imageToSnap.position
        let snapSize: CGFloat = 25
        
        for image in images where imageToSnap.id != image.id {
            if image.rect.intersects(imageToSnap.rect) {
                print("imageToSnap", imageToSnap.rect)
                print("image", image.rect)
                
                
                let intersection = imageToSnap.rect.intersection(image.rect)
                print("width", intersection.width)
                //snap horizontally
                if intersection.width < snapSize {
                    if imageToSnap.rect.minX > image.rect.midX { //snap to right
                        images[index].position.x = image.rect.maxX
//                        images[index].position = imageToSnap.rect.offsetBy(dx: intersection.width, dy: 0).origin
                        print("offset", image.rect.offsetBy(dx: intersection.width, dy: 0).origin)
                    } else {
                        images[index].position = imageToSnap.rect.offsetBy(dx: -intersection.width, dy: 0).origin
//                        images[index].position = image.rect.offsetBy(dx: -intersection.minX, dy: 0).origin
                    }
                }
                
                
                //snap vertically
            }
        }
        return .zero
    }
}
