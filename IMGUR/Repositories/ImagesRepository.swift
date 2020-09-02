//
//  ImagesRepository.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageRepository {
    func getTopGallery(page: Int) -> Observable<[Album]>
}

class ImageRepositoryImpl: ImageRepository {
    
    class var shared: ImageRepository {
        struct Static {
            static let instance = ImageRepositoryImpl(api: Service.shared)
        }
        return Static.instance
    }
    
    let api: Service
    
    init(api: Service) {
        self.api = api
    }
    
    func getTopGallery(page: Int) -> Observable<[Album]> {
        return api.request(GalleryEndPoint.getTop(page: page))
            .map({ (response: APIResponseProtocol) -> [Album] in
                if response.success, let succes = response as? APIResponseSuccess {
                    return succes.data
                } else if let failure = response as? APIResponseFailure {
                    throw BaseError.apiError(error: failure.data)
                } else {
                    throw BaseError.unexpectedError
                }
            }).map({ album in
                return album.filter({ album in album.images != nil})
            }).retry(2)
    }
}
