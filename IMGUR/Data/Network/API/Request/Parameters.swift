//
//  Parameters.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

struct Parameters {
    
    var parameters: [String: String]
    
    init(_ parameters: [String: String]) {
        self.parameters = parameters
    }
    
    func get() -> String {
        var params = self.parameters.reversed()
        let first = params.removeFirst()
        var paramString = "?\(first.key)=\(first.value)"
        for (key, value) in params {
            paramString += "&\(key)=\(value)"
        }
        return paramString
    }
}
