//
//  Router.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import Foundation
import RxSwift

class Service {
    
    static let shared = Service()
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint) -> Observable<APIResponseProtocol> {
        return Observable<APIResponseProtocol>.create { observer in
            do {
                let request = try self.buildRequest(from: route)
                self.task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    do {
                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data ?? Data())
                        let model: APIResponseProtocol = apiResponse.success ? try JSONDecoder().decode(APIResponseSuccess.self, from: data ?? Data()) : try JSONDecoder().decode(APIResponseFailure.self, from: data ?? Data())
                        observer.onNext(model)
                    } catch {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
                self.task?.resume()
            } catch {
                observer.onError(error)
                observer.onCompleted()
            }
            return Disposables.create {
                self.task?.cancel()
            }
        }
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        guard let url = route.baseURL?.appendingPathComponent(route.path) else { throw BaseError.urlError }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        for (key, value) in route.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        do {
            switch route.task {
            case .request:
                request.setValue("apllication/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParameters(let parameters):
                try self.setParameters(parameters: parameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func setParameters(parameters: Parameters, request: inout URLRequest) throws {
        guard let url = request.url else { throw BaseError.urlError }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters.parameters {
                let queryItem = URLQueryItem(name: key, value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
}
