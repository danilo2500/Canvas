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
    let initialSize: CGSize = CGSize(width: 87, height: 130)
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
    
    private let snapThreshold: CGFloat = 10
    
    
    
    // MARK: Properties
    @Published var snapLines: [SnapLine] = []
    
    @Published var images: [CanvasImage] = []
    
    // MARK: Public Functions
    
    func updatePosition(by location: CGPoint, for id: UUID, canvasSize: CGSize) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].position = location
                snapToGuidelinesIfNeeded(canvasSize: canvasSize, for: id)
            }
        }
    }
    
    func update(scale: CGFloat, for id: UUID) {
        if let index = images.firstIndex(where: { $0.id == id }) {
            if images[index].isSelected {
                images[index].size.width = images[index].initialSize.width * scale
                images[index].size.height = images[index].initialSize.height * scale
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
    
    private func snapToGuidelinesIfNeeded(canvasSize: CGSize, for id: UUID) {
        removeAllSnapLines()
        snapToCanvasIfNeeded(canvasSize: canvasSize, for: id)
        snapToImagesIfNeeded(canvasSize: canvasSize, for: id)
    }
    
    private func snapToCanvasIfNeeded(canvasSize: CGSize, for id: UUID) {
        guard let index = images.firstIndex(where: { $0.id == id }) else { return }
        let movingImage = images[index]
        let rect = calculateRectOfSnappingArea(of: movingImage)
        let canvasRect = CGRect(origin: .zero, size: canvasSize)
        
        if rectIsOnLeftEdge(rect, of: canvasRect.minX) {
            images[index].position.x = rect.width / 2
            snapLines.append(SnapLine(orientation: .vertical(xPosition: 0)))
        } else if rectIsOnRightEdge(rect, of: canvasRect.maxX) {
            images[index].position.x = canvasSize.width - rect.width / 2
            snapLines.append(SnapLine(orientation: .vertical(xPosition: canvasSize.width)))
        }
        
        if rectIsOnTopEdge(rect, of: canvasRect.maxY) {
            images[index].position.y = canvasSize.height - rect.height / 2
            snapLines.append(SnapLine(orientation: .horizontal(yPosition: canvasSize.height)))
        } else if rectIsOnBottomEdge(rect, of: canvasRect.minY) {
            images[index].position.y = rect.height / 2
            snapLines.append(SnapLine(orientation: .horizontal(yPosition: 0)))
        }
    }
    
    private func snapToImagesIfNeeded(canvasSize: CGSize, for id: UUID) {
        guard let index = images.firstIndex(where: { $0.id == id }) else { return }
        let movingImage = images[index]
        let rect = calculateRectOfSnappingArea(of: movingImage)
        
        for image in images where movingImage.id != image.id {
            let otherRect = calculateRectOfSnappingArea(of: image)
            
            if rectIsOnRightEdge(rect, of: otherRect.minX) {
                images[index].position.x = otherRect.minX - rect.width / 2
                snapLines.append(SnapLine(orientation: .vertical(xPosition: otherRect.minX)))
            }
            if rectIsOnLeftEdge(rect, of: otherRect.maxX) {
                images[index].position.x = otherRect.maxX + rect.width / 2
                snapLines.append(SnapLine(orientation: .vertical(xPosition: otherRect.maxX)))
            }
            if rectIsOnTopEdge(rect, of: otherRect.minY) {
                images[index].position.y = otherRect.minY - rect.height / 2
                snapLines.append(SnapLine(orientation: .horizontal(yPosition: otherRect.minY)))
            }
            if rectIsOnBottomEdge(rect, of: otherRect.maxY) {
                images[index].position.y = otherRect.maxY + rect.height / 2
                snapLines.append(SnapLine(orientation: .horizontal(yPosition: otherRect.maxY)))
            }
        }
    }
    
    private func rectIsOnLeftEdge(_ rect: CGRect, of xPosition: CGFloat) -> Bool {
        return positionIsOnSnapingRangeOfPoint(rect.minX, point: xPosition)
    }
    
    private func rectIsOnRightEdge(_ rect: CGRect, of xPosition: CGFloat) -> Bool {
        return positionIsOnSnapingRangeOfPoint(rect.maxX, point: xPosition)
    }
    
    private func rectIsOnTopEdge(_ rect: CGRect, of yPosition: CGFloat) -> Bool {
        return positionIsOnSnapingRangeOfPoint(rect.maxY, point: yPosition)
    }
    
    private func rectIsOnBottomEdge(_ rect: CGRect, of yPosition: CGFloat) -> Bool {
        return positionIsOnSnapingRangeOfPoint(rect.minY, point: yPosition)
    }
    
    private func positionIsOnSnapingRangeOfPoint(_ position: CGFloat, point: CGFloat) -> Bool {
        return ((point - snapThreshold)...(point + snapThreshold)).contains(position)
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
