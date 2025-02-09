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

struct SnapLine: Identifiable {
    let id = UUID()
    var orientation: Orientation
    
    enum Orientation {
        case horizontal(yPosition: CGFloat)
        case vertical(xPosition: CGFloat)
    }
}

class CanvasViewModel: ObservableObject {
    
    // MARK: Private Properties
    
    private let snapThreshold: CGFloat = 20
    
    
    
    // MARK: Properties
    @Published var snapLines: [SnapLine] = []
    
    @Published var images: [CanvasImage] = []
    
    // MARK: Public Functions
    
    func updatePosition(by location: CGPoint, for id: UUID, canvasSize: CGSize) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].position = location
                snapToGuidelinesIfNeeded(imageToSnap: images[index], canvasSize: canvasSize)
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
    private func snapToGuidelinesIfNeeded(imageToSnap: CanvasImage, canvasSize: CGSize)  {
        removeAllSnapLines()
        guard let index = images.firstIndex(where: { $0.id == imageToSnap.id }) else { return }
        let rect = calculateRectOfSnappingArea(of: imageToSnap)

        if rect.minX < 0, rect.minX > -snapThreshold { //snap to left
            images[index].position.x = rect.width / 2
            snapLines.append(SnapLine(orientation: .vertical(xPosition: 0)))
        } else if rect.maxX > canvasSize.width, rect.maxX < canvasSize.width + snapThreshold { //snap to right
            images[index].position.x = canvasSize.width - rect.width / 2
            snapLines.append(SnapLine(orientation: .vertical(xPosition: canvasSize.width)))
        }
        
        if rect.minY < 0, rect.minY > -snapThreshold { //snap to top
            images[index].position.y = rect.height / 2
            snapLines.append(SnapLine(orientation: .horizontal(yPosition: 0)))
        } else if rect.maxY > canvasSize.height, rect.maxY < canvasSize.height + snapThreshold { //snap to top
            images[index].position.y = canvasSize.height - rect.height / 2
            snapLines.append(SnapLine(orientation: .horizontal(yPosition: canvasSize.height )))
        }

        for image in images where imageToSnap.id != image.id { // Snap between images
            let otherRect = calculateRectOfSnappingArea(of: image)
            
            
            if rect.intersects(otherRect) {
                let intersection = rect.intersection(otherRect)
                if intersection.width < snapThreshold {
                    if otherRect.midX < rect.minX { //Snap to right
                        images[index].position.x += intersection.width
                        snapLines.append(SnapLine(orientation: .vertical(xPosition: otherRect.origin.x + otherRect.size.width)))
                    } else { //Snap to left
                        images[index].position.x -= intersection.width
                        snapLines.append(SnapLine(orientation: .vertical(xPosition: otherRect.origin.x)))
                    }
                    print(images[index].position.x)
                    
                }
                if intersection.height < snapThreshold {
                    if otherRect.midY < rect.minY { //Snap to top
                        images[index].position.y += intersection.height
                        snapLines.append(SnapLine(orientation: .horizontal(yPosition: otherRect.origin.y + otherRect.size.height)))
                    } else { //Snap to bottom
                        images[index].position.y -= intersection.height
                        snapLines.append(SnapLine(orientation: .horizontal(yPosition: otherRect.origin.y)))
                    }
                    print(images[index].position.y)
                    
                }
            }
        }
    }
    
    func removeAllSnapLines() {
        snapLines.removeAll()
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
