//
//  ContentView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI
import AVFoundation
import RealmSwift

struct ContentView: View {
    @State private var isShowingAddDuty: Bool = false
    @State private var isShowingSettings: Bool = false
    @State private var isShowingPopUp: Bool = false
    @State private var isLastOrderChecked: Bool = false // Hot reloading

    @State private var lastName = ""
    @State private var lastOrderPrice = ""

    @ObservedResults(Duty.self) var duties
    @ObservedResults(UserSettings.self) var settings

    var body: some View {
        NavigationStack {
            List {
                ForEach(duties.sorted(byKeyPath: "date")) { duty in
                    NavigationLink(destination: AboutDutyView(duty: duty)) {
                        CellView(duty: duty)
                    }
                }
                .onDelete(perform: $duties.remove)
            }
                    .navigationBarTitle("Payback", displayMode: .large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isShowingAddDuty = true
                                lastOrderPrice = ""
                            }) {
                                Image(systemName: "plus")
                            }
                                .sheet(isPresented: $isShowingAddDuty) {
                                    AddDutyView(sum: lastOrderPrice)
                                }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
        }
        .alert(isPresented: $isShowingPopUp) {
            Alert(
                title: Text("Совершена поездка!"),
                message: Text("Вышло на " + lastOrderPrice + "₽. Добавить долг?"),
                primaryButton: .default(
                        Text("Да"),
                        action: {
                            isShowingAddDuty = true
                        }
                ),
                secondaryButton: .cancel(Text("Отмена"))
            )
        }

        .onAppear {
            if !isLastOrderChecked, let userSettings = settings.first {
                isLastOrderChecked = true
                CityDriveManager().getLastOrder(sessionId: userSettings.sessionId) { result in
                    switch result {
                    case .success(let model):
                        if model == nil {
                            print("No response") // TODO: handle nil model
                        }
                        print(model?.success)
                        let newSettings: UserSettings = UserSettings(
                                sessionId: userSettings.sessionId,
                                lastOrderId: (model?.orders![0].orderId)!,
                                firstName: userSettings.firstName,
                                middleName: userSettings.middleName,
                                lastName: userSettings.lastName
                        )

                        if userSettings.lastOrderId != (model?.orders?[0].orderId)! {
                            for s in settings {
                                $settings.remove(s)
                            }
                            $settings.append(newSettings)

                            if let amount = model!.orders![0].amount {
                                lastOrderPrice = String(amount.prefix(amount.count - 2))
                            }
                            isShowingPopUp = true
                        }
                        break;
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: handle error
                        break;
                    }
                }
            }
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
    #endif
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
