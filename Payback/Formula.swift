//
//  Formula.swift
//  Payback
//
//  Created by Иван Вдовин on 09.03.2023.
//

import Foundation

class Formula {
    var percent: Int16 = 20
    
    // (sum / peopleCount) * (1 + (percent/(100*peopleCount))) - формула
    func calculate(peopleCount: Int16, sum: String) -> Double {
        return (NumberFormatter().number(from: sum)?.doubleValue ?? 0) / Double(peopleCount) * (1 + (Double(self.percent)/(100 * Double(peopleCount))))
    }
}
