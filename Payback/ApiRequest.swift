//
//  ApiRequest.swift
//  Payback
//
//  Created by Иван Вдовин on 17.02.2023.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ApiRequest<T> where T: Mappable {
    var method: HTTPMethod
    var url: String
    var params: [String : Any]
    var headers: [String : String]
    
    init(method: HTTPMethod = .get, url: String, params: [String : Any], headers: [String : String]) {
        self.method = method
        self.url = url
        self.params = params
        self.headers = headers
    }
    
    func send(completion: @escaping (Result<T?>) -> Void) {
        Alamofire
            .request(
                url,
                method: self.method,
                parameters: self.params,
                encoding: URLEncoding.default,
                headers: self.headers
            )
            .responseObject {(response: DataResponse<T>) in
            let result = response.result.value
            completion(.success(result)) // TODO: handle .failure
        }
    }
}
