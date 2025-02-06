//
//  PhotosModel.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import Foundation

import Foundation
struct Photos : Codable {
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
}
