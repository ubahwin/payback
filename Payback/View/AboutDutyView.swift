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
    @State private var rePeopleCount: Int16 = 2
    @State private var reDate = Date()
    @State private var reAbout: String = ""
    
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
                        Stepper(value: $rePeopleCount, in: Int16(duty.peopleCount) ... 30) {
                            Text("Кол-во человек: " + String(rePeopleCount))
                        }
                    }
                    HStack {
                        DatePicker(selection: $reDate, label: { Text("Дата") })
                            .environment(\.locale, Locale(identifier: "ru_RU"))
                    }
                    HStack {
                        Text("Описание")
                        TextField(duty.about, text: $reAbout)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            //refresh
                            duty.sum = NumberFormatter().number(from: reSum)?.doubleValue ?? 0
                            isEditing = false
                        }) {
                            Text("Обновить")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle (cornerRadius: 5))
                        Spacer()
                    }
                } else {
                    HStack {
                        Text("Cумма")
                        Spacer()
                        Text(Formatter.getFormattedNumber(number: duty.sum) + "₽")
                            .textSelection(.enabled)
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
                        Text(String(Formatter.getFormattedNumber(number: duty.dutyPrice) + "₽"))
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
                        self.isEditing.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
}
