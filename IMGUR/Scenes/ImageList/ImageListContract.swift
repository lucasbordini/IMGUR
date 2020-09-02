//
//  ImageListContract.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation

protocol ImageListView: class {
    func onSuccess(albums: [Album], reset: Bool)
    func onError(error: BaseError)
}

protocol ImageListPresenter: class {
    func load()
    func loadMore()
    func reload()
    
}
