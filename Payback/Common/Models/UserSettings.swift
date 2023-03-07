//
//  UserSettings.swift
//  Payback
//
//  Created by Иван Вдовин on 26.02.2023.
//

import Foundation
import RealmSwift

class UserSettings: Object, ObjectKeyIdentifiable {
    @Persisted var sessionId: String
    @Persisted var lastOrderId: String
    @Persisted var firstName: String
    @Persisted var middleName: String
    @Persisted var lastName: String

    convenience init(sessionId: String, lastOrderId: String, firstName: String, middleName: String, lastName: String) {
        self.init()
        self.sessionId = sessionId
        self.lastOrderId = lastOrderId
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
}
