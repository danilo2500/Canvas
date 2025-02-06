//
//  OverlaysViewModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation
import SwiftUI

class OverlaysViewModel: ObservableObject {
    
    @Published var images: [String] = []
    @Published var isLoading: Bool = false
    
    func fetchImages() {
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.images = [
                "star.fill", "heart.fill", "camera.fill", "bell.fill", "airplane",
                "cloud.fill", "leaf.fill", "moon.fill"
            ]
            self.isLoading = false
        }
    }
}
