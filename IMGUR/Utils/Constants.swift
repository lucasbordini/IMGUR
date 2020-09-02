//
//  Constants.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

enum Constants {
    
    enum URLs: String {
        case baseURL = "https://api.imgur.com/"
    }
    
    enum Keys: String {
        case clientID = "c22632767296da7"
        case clientSecret = "41304fd906fe05cda6cda5292c2331ac833dc7a2"
    }
    
    enum ReuseIdentifiers {
        enum ImageList: String {
            case ImageCell = "imageCell"
        }
    }
    
    enum NibNames {
        enum ImageList: String {
            case ImageCell = "ImageCell"
        }
    }
}
