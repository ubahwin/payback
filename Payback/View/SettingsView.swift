//
//  SettingsView.swift
//  Payback
//
//  Created by Иван Вдовин on 07.02.2023.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    @State var isDarkMode: Bool = true

    @ObservedResults(UserSettings.self) var userSettings

    private func changeAppIcon(to iconName: String) {
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("Error setting alternate icon \(error.localizedDescription)")
            }
        }
    }
    
    let dataIcon: [String] = [
        "RetroWave",
        "Happy",
        "Alien",
        "Airline",
        "Doomer",
        "Dead Inside"
    ]
    
    func AppIconButton(imageName: String) -> some View {
        HStack {
            Text(imageName)
            Spacer()
            Button(action: { changeAppIcon(to: imageName) }, label: {
                Image(imageName)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                    .padding()
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        SettingsLoginCityDriveView()
                    } label: {
                        HStack {
                            Text("Войти в СитиДрайв")
                            Spacer()
                            if let settings = userSettings.first {
                                Text(settings.firstName).colorMultiply(.gray)
                            }
                        }
                    }
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Text("Войти в Делимобиль")
                    }
                }
                Section {
                    Toggle("Темная тема", isOn: $isDarkMode)
                    NavigationLink("Сменить иконку") {
                        List {
                            AppIconButton(imageName: "AppIconAlien")
                            AppIconButton(imageName: "AppIconDeadInside")
                            AppIconButton(imageName: "AppIconAirline")
                            AppIconButton(imageName: "AppIconHappy")
                            AppIconButton(imageName: "AppIconDoomer")
                        }
                    }
                    Button("path") {
                        let realm = try! Realm()
                        print(realm.configuration.fileURL!)
                    }
                }
            }
            .navigationBarTitle("Настройки", displayMode: .large)
            .listStyle(.grouped)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

