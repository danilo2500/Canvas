//
//  OverlaysViewModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation
import SwiftUI

class OverlaysViewModel: ObservableObject {
    
    @Published var imagesURL: [URL] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    // MARK: Private properties
    
    private let service = OverlaysService(service: RESTService<PexelsAPI>())
    
    // MARK: Functions
    
    func fetchImages() {
//        self.images = [
//            "star.fill", "heart.fill", "camera.fill", "bell.fill", "airplane",
//            "cloud.fill", "leaf.fill", "moon.fill"
//        ]
        self.isLoading = true
        
        service.fetchCuratedPhotos(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.imagesURL = response.photos.map(\.src.small)
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert = true
            }
        }
    }
}
