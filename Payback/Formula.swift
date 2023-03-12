//
//  Formula.swift
//  Payback
//
//  Created by Иван Вдовин on 09.03.2023.
//

import Foundation

class Formula {
    var percent: Double = 20
    
    // (sum / peopleCount) * (1 + (percent/(100*peopleCount))) - формула
    func calculate(peopleCount: Double, sum: Double) -> Double {
        return sum / peopleCount * (1 + (self.percent/(100 * peopleCount)))
    }
}
