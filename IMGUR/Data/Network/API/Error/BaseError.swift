//
//  BaseError.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

enum BaseError: Error {
    
    case networkError
    case httpError(httpCode: Int)
    case unexpectedError
    case apiError(error: ErrorResponse)
    case urlError
    
    
    public var errorMessage: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .httpError(let code):
            return getErrorMessage(for: code)
        case .apiError(let error):
            return error.error
        case .urlError:
            return "Error with URL called"
        default:
            return "Unexpected Error"
        }
    }
    
    private func getErrorMessage(for httpCode: Int) -> String {
        if (httpCode >= 300 && httpCode <= 308) {
            return "It was tranferred to another URL. Please contact the support"
        } else if (httpCode >= 400 && httpCode <= 451) {
            return "An error occurred on the apllication side. Please contact the support"
        } else if (httpCode >= 500 && httpCode <= 511) {
            return "A server error occurred. Please try again later!"
        } else {
            return "A error occurred. Please try again later!"
        }
    }
}
