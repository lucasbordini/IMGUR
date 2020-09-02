//
//  EndPoint.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

protocol EndPoint {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var task: HTTPTask { get }
}

