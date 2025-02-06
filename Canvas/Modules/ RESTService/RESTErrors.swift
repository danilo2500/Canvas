//
//  NSErrors.swift
//  REST-Service
//
//  Created by Danilo Henrique on 15/04/24.
//

import Foundation

enum RESTError: Error {
    case failedToCreateURL
    case failedToCreateImage
}


// MARK: - Error Descriptions

extension RESTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToCreateURL:
            return "Failed to create URL"
        case .failedToCreateImage:
            return "Data provided could not create image"
        }
    }
}
