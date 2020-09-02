//
//  HTTPTask.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

enum HTTPTask {
    case request
    case requestWithParameters(urlParameters: Parameters)
}
