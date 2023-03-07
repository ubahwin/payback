//
//  CellView.swift
//  Payback
//
//  Created by Иван Вдовин on 26.10.2022.
//

import SwiftUI
import RealmSwift

struct CellView: View {

    @ObservedRealmObject var duty: Duty
    
    var body: some View {
        HStack {
            Image(duty.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                Text(Formatter.getFormattedNumber(number: duty.sum) + "₽")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    Text(String(Formatter.getFormattedNumber(number: duty.dutyPrice) + "₽"))
                    Text(Formatter.getFormattedDate(date: duty.date))
                }
            }
        }
    }
}
