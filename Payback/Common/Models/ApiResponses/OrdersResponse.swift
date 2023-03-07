//
// Created by Иван Вдовин on 05.03.2023.
//

import Foundation
import ObjectMapper

class OrdersResponse: Mappable {
    var orders: [OrderItem]?
    var shortUserInfo: ShortUserInfo?
    var count: Int?
    var success: Bool?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        orders <- map["orders"]
        shortUserInfo <- map["user"]
        count <- map["count"]
        success <- map["success"]
    }
}

class ShortUserInfo {
    var firstName: String?
    var lastName: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
    }
}
