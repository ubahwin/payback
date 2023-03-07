//
//  SettingsLoginCityDriveView.swift
//  Payback
//
//  Created by Иван Вдовин on 07.02.2023.
//

import SwiftUI

struct SettingsLoginCityDriveView: View {
    
    @State var phoneNumber: String = ""

    let manager: CityDriveManager = CityDriveManager()

    var body: some View {
        NavigationStack {
            
            Text("Номер телефона").font(.largeTitle)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("+7")
                TextField("", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .frame(maxWidth: 220)
//                    .multilineTextAlignment(.center)
                Spacer()
            }
                .font(.largeTitle)

            Spacer()
            
            NavigationLink(destination: SettingsLoginCityDriveSmsView(manager: manager)) {
                 Text("Продолжить")
            }
            .simultaneousGesture(TapGesture().onEnded{
                print("phone: " + phoneNumber)

                manager.sendSmsCode(phone: phoneNumber) { result in
                    switch result {
                        case .success(let model):
                            if model == nil {
                                print("No response") // TODO: hanlde nil model
                            }
                            break;
                        case .failure(let error):
                            print(error.localizedDescription) // TODO: handle error
                            break;
                    }
                }
                
            })
            .buttonStyle(BlueButton())
            
            Spacer().frame(height: 50)
        }
    }
}

struct SettingsLoginCityDriveView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLoginCityDriveView()
    }
}
