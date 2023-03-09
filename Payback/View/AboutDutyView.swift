//
//  AboutDutyView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI
import RealmSwift

struct AboutDutyView: View {
    @ObservedRealmObject var duty: Duty
    
    @State private var showActionSheet = false
    @State private var isEditing = false
    
    @Environment(\.presentationMode) var presentationMode
        
    @State private var reSum: String = ""
    
    var body: some View {
        VStack {
            List {
                if isEditing == true {
                    HStack {
                        Text("Cумма")
                        TextField(Formatter.getFormattedNumber(number: duty.sum), text: $reSum)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Stepper(value: $duty.peopleCount, in: 2 ... 30) {
                            Text("Кол-во человек: " + String(duty.peopleCount))
                        }
                    }
                    HStack {
                        DatePicker(selection: $duty.date, label: { Text("Дата") })
                            .environment(\.locale, Locale(identifier: "ru_RU"))
                    }
                    HStack {
                        Text("Описание")
                        TextField(duty.about, text: $duty.about)
                    }
                } else {
                    HStack {
                        Text("Cумма")
                        Spacer()
                        Text(Formatter.getFormattedNumber(number: duty.sum) + "₽")
                    }
                    HStack {
                        Text("Кол-во человек")
                        Spacer()
                        Text(String(duty.peopleCount))
                    }
                    HStack {
                        Text("Дата")
                        Spacer()
                        Text(Formatter.getFormattedDate(date: duty.date, format: "dd MMMM YYYY hh:mm"))
                    }
                    HStack {
                        Text("Долг")
                        Spacer()
                        Text(String(Formatter.getFormattedNumber(number: duty.dutyPrice)) + "₽")
                            .textSelection(.enabled)
                    }
                    HStack {
                        Text("Описание")
                        Spacer()
                        Text(duty.about)
                    }
                }
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .navigationBarTitle(duty.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isEditing {

                            if reSum != "" {
                                $duty.sum.wrappedValue = Double(Formatter.getFormattedNumber(number: Double(reSum)!))!
                            }
                            print(duty.name, duty.peopleCount, duty.sum, duty.dutyPrice)
                            if duty.name == "Каршеринг" { // TODO: refactor
                                $duty.dutyPrice.wrappedValue = Formula().calculate(peopleCount: duty.peopleCount, sum: String(duty.sum))
                            } else {
                                $duty.dutyPrice.wrappedValue = duty.sum / Double(duty.peopleCount)
                            }
                            
                        }
                        self.isEditing.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
}
