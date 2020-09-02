//
//  ImageDataService.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation
import RxSwift

class ImageDataService {
    
    private var task: URLSessionTask?
    
    private let cache = NSCache<NSString, UIImage>()
    
    static let shared = ImageDataService()
    
    func get(url urlString: String) -> Observable<UIImage> {
        return Observable.create { observer in
            if let image = self.cache.object(forKey: urlString as NSString) {
                observer.onNext(image)
                observer.onCompleted()
            } else {
                if let url = URL(string: urlString) {
                    let request = URLRequest(url: url)
                    self.task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            self.cache.setObject(image, forKey: urlString as NSString)
                            observer.onNext(image)
                        } else {
                            observer.onError(BaseError.urlError)
                        }
                        observer.onCompleted()
                    }
                    self.task?.resume()
                } else {
                    observer.onError(BaseError.urlError)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
}
