//
//  WebService.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class WebService {
    private let session: NetworkSession

    init(session: NetworkSession) {
        self.session = session
    }

    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void) {
        session.perform(with: request) { (data, response, error) in
            self.handleResponse(data, httpResponse: response as? HTTPURLResponse, error: error, callback: callback)
        }
    }
    
    private func handleResponse<T: Decodable>(_ data: Data?, httpResponse: HTTPURLResponse?, error: Error?, callback: (Response<T>) -> Void) {
        if let error = error {
            callback(.error(error))
        } else if let data = data  {
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                callback(.success(result))
            } catch let error {
                handleError(error, data: data, httpResponse: httpResponse, callback: callback)
            }
        } else {
            callback(.error(WebServiceError.ambigousResponse))
        }
    }

    private func handleError<T: Decodable>(_ error: Error, data: Data, httpResponse: HTTPURLResponse?, callback: (Response<T>) -> Void) {
        if httpResponse?.statusCode != 200 {
            let errorObject = try? JSONSerialization.jsonObject(with: data, options: [])
            callback(.error(WebServiceError.serviceError(errorObject: errorObject)))
        } else {
            callback(.error(error))
        }
    }
}

enum WebServiceError: Error {
    case ambigousResponse, serviceError(errorObject: Any?)
}
