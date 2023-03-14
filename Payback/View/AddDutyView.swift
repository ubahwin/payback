//
//  AddDutyView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI
import RealmSwift

struct AddDutyView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedResults(Duty.self) var dutyRealm

    @State var sum: String
    @State var peopleCount: Int16 = 2
    @State var date = Date()
    @State var about: String = ""
    @State var duty: Double = 0
    @State var image: String = "Carsh"
    @State var name: String = "Каршеринг"
    let percent: Int16 = 20
    
    enum DutyTypeEnum: String, CaseIterable, Identifiable {
        case carsh, other
        var id: Self { self }
    }
    @State var type: DutyTypeEnum = .carsh

    func takeType(type: DutyTypeEnum) {
        switch type {
        case .other:
            image = "Money"
            name = "Другое"
            duty = (NumberFormatter().number(from: sum)?.doubleValue ?? 0) / Double(peopleCount)
        default:
            duty = Formula().calculate(
                peopleCount: Double(peopleCount),
                sum: Double(sum.replacingOccurrences(of: ",", with: ".")) ?? 0
            )
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Выберите тип", selection: $type) {
                    Text("Каршеринг").tag(DutyTypeEnum.carsh)
                    Text("Другое").tag(DutyTypeEnum.other)
                }
                Stepper(value: $peopleCount, in: 2 ... 20) {
                    Text("Кол-во человек: " + String(peopleCount))
                }

                HStack {
                    Text("Сумма: ")
                    Spacer()
                    TextField("Впишите...", text: $sum)
                        .keyboardType(.decimalPad)
                }

                DatePicker(selection: $date, label: { Text("Дата") })
                    .environment(\.locale, Locale(identifier: "ru_RU"))

                TextField("Описание...", text: $about)
                
                HStack {
                    Spacer()
                    Button(action: {
                        takeType(type: type)

                        // add duty in realm
                        let newDuty = Duty(
                                name: name,
                                sum: Double(sum.replacingOccurrences(of: ",", with: ".")) ?? 0, // TODO: refactor
                                peopleCount: peopleCount,
                                image: image,
                                dutyPrice: duty,
                                date: date,
                                about: about
                        )
                        $dutyRealm.append(newDuty)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Создать")
                    }
                            .disabled(sum.isEmpty)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle (cornerRadius: 5))
                    Spacer()
                }
            } .listStyle(.grouped)
                .navigationBarTitle("Добавить счёт", displayMode: .large)
                .navigationBarItems(
                    trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Закрыть")
                    }
                )
                .padding()
        }
    }
}
