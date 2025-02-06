//
//  OverlaysService.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation

protocol OverlaysServiceProtocol {
    func fetchCuratedPhotos(page: Int, completion: @escaping (Result<CuratedPhotosResponse, Error>) -> Void)
}

class OverlaysService {
    let service: RESTService<PexelsAPI>
    
    init(service: RESTService<PexelsAPI>) {
        self.service = service
    }
}

//MARK: - DetailService Protocol

extension OverlaysService: OverlaysServiceProtocol {
    
    func fetchCuratedPhotos(page: Int, completion: @escaping (Result<CuratedPhotosResponse, Error>) -> Void) {
        service.request(.getCuratedPhotos(page: String(page)), completion: completion)
    }
    
}
