//
//  SmsCodeResponse.swift
//  Payback
//
//  Created by Иван Вдовин on 17.02.2023.
//

import Foundation
import ObjectMapper

class SmsCodeResponse: Mappable {
    var step: String?
    var phone: String?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        step <- map["step"]
        phone <- map["phone"]
        success <- map["success"]
    }
}
