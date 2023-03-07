//
//  CityDriveManager.swift
//  Payback
//
//  Created by Иван Вдовин on 17.02.2023.
//

import Foundation

class CityDriveManager { // TODO: inherit from CarsharingManager
    public var phone: String?

    let defaultHeaders: [String : String] = [
        "User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"
    ]

    func sendSmsCode(phone: String, completion: @escaping (Result<SmsCodeResponse?, Error>) -> Void) {
        self.phone = phone

        let url = "https://api.citydrive.ru/signup?version=20"
        let params = [
            "os": "android",
            "phone": phone,
            "phone_code": "7",
            "vendor_id": "86bdb8236b314b96"
        ]

        ApiRequest<SmsCodeResponse>(method: .post, url: url, params: params, headers: defaultHeaders).send() { result in
            switch result {
                case .success(let model):
                    completion(.success(model))
                    break;
                case .failure(let error):
                    completion(.failure(error))
                    break;
            }
        }
    }
    
    func authByCode(smsCode: String, completion: @escaping (Result<SessionResponse?, Error>) -> Void) {
        let url = "https://api.citydrive.ru/signup/code?version=20"
        let params: [String : Any] = [
            "os": "android",
            "code": Int(smsCode)!,
            "vendor_id": "86bdb8236b314b96",
            "phone": phone!,
            "phone_code": "7"
        ]
        
        ApiRequest<SessionResponse>(method: .post, url: url, params: params, headers: defaultHeaders).send() { result in
            switch result {
                case .success(let model):
                    completion(.success(model))
                    break;
                case .failure(let error):
                    completion(.failure(error))
                    break;
            }
        }
    }

    func getLastOrder(sessionId: String, completion: @escaping (Result<OrdersResponse?, Error>) -> Void) {
        let url = "https://api.citydrive.ru/orders?type=user&limit=1&page=1&version=19"
        let headers: [String : String] = [
            "User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)",
            "Cookie": "session_id=" + sessionId
        ]
        ApiRequest<OrdersResponse>(method: .get, url: url, params: [:], headers: headers).send() { result in
            switch result {
            case .success(let model):
                completion(.success(model))
                break;
            case .failure(let error):
                completion(.failure(error))
                break;
            }
        }
    }
}
