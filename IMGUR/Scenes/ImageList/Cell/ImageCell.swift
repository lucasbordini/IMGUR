//
//  ImageCell.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import UIKit
import RxSwift

class ImageCell: UITableViewCell {
    
    @IBOutlet private weak var imageBox: UIImageView!
    @IBOutlet private weak var upvotes: UILabel!
    @IBOutlet private weak var comments: UILabel!
    @IBOutlet private weak var views: UILabel!
    @IBOutlet private weak var retry: UIButton!
    @IBOutlet private weak var loading: UIActivityIndicatorView!
    
    private let bag = DisposeBag()
    
    private var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(album: Album) {
        upvotes.text = String(describing: album.ups)
        comments.text = String(describing: album.comments)
        views.text = String(describing: album.views)
        urlString = album.images?.first?.link ?? ""
    }
    
    private func loadImage() {
        self.retry.isHidden = true
        loading.startAnimating()
        ImageDataService.shared.get(url: urlString)
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .retry(1)
            .subscribe(onNext: { [weak self] image in
                self?.loading.stopAnimating()
                self?.imageBox.image = image
                }, onError: { [weak self] _ in
                    self?.loading.stopAnimating()
                    self?.retry.isHidden = false
            }).disposed(by: bag)
    }
    
    @IBAction private func retryLoad() {
        loadImage()
    }
    
}

class ImageCCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageBox: UIImageView!
    @IBOutlet private weak var upvotes: UILabel!
    @IBOutlet private weak var comments: UILabel!
    @IBOutlet private weak var views: UILabel!
    @IBOutlet private weak var retry: UIButton!
    @IBOutlet private weak var loading: UIActivityIndicatorView!
    
    private let bag = DisposeBag()
    
    private var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(album: Album) {
        upvotes.text = String(describing: album.ups)
        comments.text = String(describing: album.comments)
        views.text = String(describing: album.views)
        urlString = album.images?.first?.link ?? ""
    }
    
    private func loadImage() {
        self.retry.isHidden = true
        loading.startAnimating()
        ImageDataService.shared.get(url: urlString)
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .retry(1)
            .subscribe(onNext: { [weak self] image in
                self?.loading.stopAnimating()
                self?.imageBox.image = image
                }, onError: { [weak self] _ in
                    self?.loading.stopAnimating()
                    self?.retry.isHidden = false
            }).disposed(by: bag)
    }
    
    @IBAction private func retryLoad() {
        loadImage()
    }
    
}
