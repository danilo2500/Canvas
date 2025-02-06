//
//  PexelsAPI.swift
//  Canvas
//
//  Created by Danilo Henrique on 05/02/25.
//

import Foundation

enum PexelsAPI {
    case getCuratedPhotos(page: Int)
}

extension PexelsAPI: RESTRequest {
    
    var baseURL: String {
        return "https://api.pexels.com/"
    }

    var path: String {
        switch self {
        case .getCuratedPhotos:
            return "v1/curated"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCuratedPhotos(let page):
            return [URLQueryItem(name: "per_page", value: String(page))]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCuratedPhotos:
            return .get
        }
    }
    
    var HTTPHeaderFields: [String : String]? {
        return ["Authorization": "0rWBGhCRoFiVbbq4duycTLqsvROdrjKqHdGkciUBYdubEU21DoqNC6yY"]
    }
}
