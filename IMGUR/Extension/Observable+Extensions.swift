//
//  Observable+Extensions.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import RxSwift

extension ObserverType where E == Void {
    
    func onNext() {
        onNext(())
    }
}
