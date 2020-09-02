//
//  ViewController.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class ImageListViewController: UIViewController {

    @IBOutlet private weak var imageCollection: UICollectionView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loading: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    private var presenter: ImageListPresenter?
    
    private var albums = [Album]()
    private var columns: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        let repository = ImageRepositoryImpl.shared
        presenter = ImageListPresenterImpl(view: self, repository: repository)
        presenter?.load()
    }
    
    private func setupCollection() {
        imageCollection.register(UINib(nibName: "ImageCCell", bundle: nil),
                                 forCellWithReuseIdentifier: Constants.ReuseIdentifiers.ImageList.ImageCell.rawValue)
        imageCollection.addInfiniteScroll() { [weak self] (tableView) -> Void in
            self?.presenter?.loadMore()
            tableView.finishInfiniteScroll()
        }
        if #available(iOS 10.0, *) {
            imageCollection.refreshControl = refreshControl
        } else {
            imageCollection.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
    }
    
    @objc
    @IBAction private func reload() {
        presenter?.reload()
        loading.startAnimating()
        errorView.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            columns = 2
        } else {
            columns = 1
        }
        imageCollection.layoutSubviews()
    }
}

extension ImageListViewController: ImageListView {
    
    func onSuccess(albums: [Album]) {
        self.albums.append(contentsOf: albums)
        imageCollection.reloadData()
        loading.stopAnimating()
        refreshControl.endRefreshing()
        errorView.isHidden = true
    }
    
    func onError(error: BaseError) {
        loading.stopAnimating()
        errorView.isHidden = false
        let errorAlert = Alert.createErrorAlert(message: error.errorMessage)
        present(errorAlert, animated: true)
    }
}

extension ImageListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.ImageList.ImageCell.rawValue, for: indexPath) as? ImageCCell {
            cell.setup(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionViewLayout as? UICollectionViewFlowLayout
        let space = (flow?.minimumInteritemSpacing ?? 0.0) + (flow?.sectionInset.left ?? 0.0) + (flow?.sectionInset.right ?? 00)
        let size = (collectionView.frame.size.width - space) / columns
        return CGSize(width: size, height: size * 0.7)
    }
}

