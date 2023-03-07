//
// Created by Иван Вдовин on 05.03.2023.
//

import Foundation
import ObjectMapper

class OrderItem: Mappable {
    var orderId: String?
    var startedAt: String?
    var amount: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        orderId <- map["order_id"]
        startedAt <- map["started_at"]
        amount <- map["amount"]
    }
}