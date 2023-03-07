//
//  Duty.swift
//  Payback
//
//  Created by Иван Вдовин on 03.03.2023.
//

import Foundation
import RealmSwift

class Duty: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var sum: Double
    @Persisted var peopleCount: Int16
    @Persisted var image: String
    @Persisted var name: String
    @Persisted var dutyPrice: Double
    @Persisted var date: Date
    @Persisted var about: String
    
    convenience init(name: String, sum: Double, peopleCount: Int16, image: String, dutyPrice: Double, date: Date, about: String) {
        self.init()
        self.name = name
        self.sum = sum
        self.peopleCount = peopleCount
        self.image = image
        self.dutyPrice = dutyPrice
        self.date = date
        self.about = about
    }
}
