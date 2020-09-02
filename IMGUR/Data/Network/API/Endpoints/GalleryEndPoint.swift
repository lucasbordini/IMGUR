//
//  GalleryEndPoint.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

enum GalleryEndPoint {
    case getTop(page: Int)
}

extension GalleryEndPoint: EndPoint {
    var baseURL: URL? {
        return URL(string: Constants.URLs.baseURL.rawValue)
    }
    
    var path: String {
        switch self {
        case .getTop(let page):
            return "3/gallery/top/top/week/\(page)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTop:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getTop:
            return ["Authorization": "Client-ID \(Constants.Keys.clientID.rawValue)"]
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getTop:
            let parameters = ["showViral":"true", "mature": "false", "album_previews": "false"]
            return .requestWithParameters(urlParameters: Parameters(parameters))
        }
    }
    
    
}
