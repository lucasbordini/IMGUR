//
//  APIResponse.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

protocol APIResponseProtocol: Codable {
    var success: Bool { get }
    var status: Int { get }
}

struct APIResponse: APIResponseProtocol {
    let success: Bool
    let status: Int
}

struct APIResponseSuccess: APIResponseProtocol {
    let data: [Album]
    let success: Bool
    let status: Int
}

struct APIResponseFailure: APIResponseProtocol {
    let data: ErrorResponse
    let success: Bool
    let status: Int
}
