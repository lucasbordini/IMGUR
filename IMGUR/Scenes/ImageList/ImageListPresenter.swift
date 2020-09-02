//
//  ImageListPresenter.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation
import RxSwift

class ImageListPresenterImpl: ImageListPresenter {
    
    private weak var view: ImageListView!
    
    private let repository: ImageRepository
    
    private let bag = DisposeBag()
    
    private var page = 0
    
    init(view: ImageListView, repository: ImageRepository) {
        self.view = view
        self.repository = repository
    }
    
    func load() {
        self.repository.getTopGallery(page: page)
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] albums in
                self?.view.onSuccess(albums: albums)
                }, onError: { [weak self] error in
                    self?.view.onError(error: error as! BaseError)
            }).disposed(by: bag)
    }
    
    func loadMore() {
        page += 1
        load()
    }
    
    func reload() {
        page = 0
        load()
    }
}
