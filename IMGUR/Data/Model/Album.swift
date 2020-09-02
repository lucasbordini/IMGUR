//
//  Image.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

class Album: Codable {
    let id: String
    let views: Int
    let ups: Int
    let images: [Image]?
    let comments: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case views
        case images
        case ups
        case comments = "comment_count"
    }
}
