//
//  SettingsLoginCityDriveSmsView.swift
//  Payback
//
//  Created by Иван Вдовин on 07.02.2023.
//

import SwiftUI
import RealmSwift

struct SettingsLoginCityDriveSmsView: View {

    @State var smsCode: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var isFinalResponse: Bool = false

    let manager: CityDriveManager

    @ObservedResults(UserSettings.self) var settings

    var body: some View {
        VStack {
            Text("Код подтверждения").font(.largeTitle)
            Spacer()
            
//            Text(response)
//                .font(.system(size: 9))
//                .fixedSize(horizontal: false, vertical: true)
//                .lineLimit(nil)
//                .border(Color.gray)
//                .textSelection(.enabled)
            TextField("******", text: $smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            
            Spacer()
            
            Button(action: {
                print("sms: " + smsCode)

                manager.authByCode(smsCode: smsCode) { result in
                    switch result {
                    case .success(let model):
                        if model == nil {
                            print("No response") // TODO: handle nil model
                        }

                        let newUserSettings = UserSettings(
                            sessionId: (model?.sessionId)!,
                            lastOrderId: "", // TODO: Remove
                            firstName: (model?.sessionUser?.firstName)!,
                            middleName: (model?.sessionUser?.middleName)!,
                            lastName: (model?.sessionUser?.lastName)!
                        )

                        manager.getLastOrder(sessionId: newUserSettings.sessionId) { result in
                            switch result {
                            case .success(let model):
                                if model == nil {
                                    print("No response") // TODO: handle nil model
                                }
                                newUserSettings.lastOrderId = (model?.orders?[0].orderId)!

                                for s in settings {
                                    $settings.remove(s)
                                }
                                $settings.append(newUserSettings) // TODO: update row
                                
                                isFinalResponse = true
                                break;
                            case .failure(let error):
                                print(error.localizedDescription) // TODO: handle error
                                break;
                            }
                        }
                        break;
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: handle error
                        break;
                    }
                }
            }) {
                Text("Войти")
            }
            .buttonStyle(BlueButton())
            Spacer().frame(height: 50)
        }
    }
}
