//
//  SessionResponse.swift
//  Payback
//
//  Created by Иван Вдовин on 17.02.2023.
//

import Foundation
import ObjectMapper

class SessionResponse: Mappable {
    var sessionId: String?
    var sessionUser: SessionUser?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sessionId <- map["session_id"]
        sessionUser <- map["user"]
        success <- map["success"]
    }
}
