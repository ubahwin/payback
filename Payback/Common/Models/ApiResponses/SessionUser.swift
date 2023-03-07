//
//  SessionUser.swift
//  Payback
//
//  Created by Иван Вдовин on 17.02.2023.
//

import Foundation
import ObjectMapper

class SessionUser: Mappable {
    var user_id: String?
    var phone: String?
    var email: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var avatar: String?
    var csLockTypeId: Any? // TODO: type?
    var loyaltyVersion: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        phone <- map["phone"]
        email <- map["email"]
        firstName <- map["first_name"]
        middleName <- map["middle_name"]
        lastName <- map["last_name"]
        avatar <- map["avatar"]
        csLockTypeId <- map["cs_lock_type_id"]
        loyaltyVersion <- map["loyalty_version"]
    }
}
