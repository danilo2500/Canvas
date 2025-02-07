//
//  OverlaysViewModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation
import SwiftUI

class OverlaysViewModel: ObservableObject {
    
    // MARK: Public properties
    
    @Published var imagesURL: [URL] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    // MARK: Private properties
    
    private let service: OverlaysServiceProtocol

    // MARK: Initialization
    
    init(service: OverlaysServiceProtocol) {
        self.service = service
    }
    
    // MARK: Functions
    
    func fetchImages() {
        self.isLoading = true
        
        service.fetchCuratedPhotos(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.imagesURL = response.photos?.compactMap(\.src?.small) ?? []
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert = true
            }
        }
    }
}
