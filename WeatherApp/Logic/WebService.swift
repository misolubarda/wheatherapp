//
//  WebService.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class WebService {
    func execute(_ request: URLRequest, callback: @escaping (Response) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            DispatchQueue.main.async { self.handleResponse(data, error: error, callback: callback) }
        })
        task.resume()
    }
    
    func handleResponse(_ data: Data?, error: Error?, callback: (Response) -> Void) {
        if let error = error {
            callback(.error(error))
        } else if let data = data  {
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = jsonObj as? [String: Any] {
                    callback(.success(result))
                } else {
                    callback(.error(WebServiceError.parsing))
                }
            } catch let error {
                callback(.error(error))
            }
        } else {
            callback(.error(WebServiceError.ambigousResponse))
        }
    }
}

enum Response {
    case success([String: Any])
    case error(Error)
}

enum WebServiceError: Error {
    case ambigousResponse, parsing
}
