//
//  PhotosResponse.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation

import Foundation

struct CuratedPhotosResponse: Codable {
    let page: Int?
    let per_page: Int?
    let photos: [PhotosResponse]?
}

struct PhotosResponse : Codable {
    let id : Int?
    let width : Int?
    let height : Int?
    let url : String?
    let photographer : String?
    let photographer_url : String?
    let photographer_id : Int?
    let avg_color : String?
    let liked : Bool?
    let alt : String?
    let src: Src?
}

struct Src : Codable {
    let original : URL?
    let large2x : URL?
    let large : URL?
    let medium : URL?
    let small : URL?
    let portrait : URL?
    let landscape : URL?
    let tiny : URL?
}
