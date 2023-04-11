//
//  SettingsView.swift
//  Payback
//
//  Created by Иван Вдовин on 07.02.2023.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    @State private var showAlert: Bool = false
    
    @ObservedResults(UserSettings.self) var userSettings

    @StateObject var appSettings: AppSettings = AppSettings()

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
                    Button("Выйти") {
                        for settings in userSettings {
                            $userSettings.remove(settings)
                        }
                        showAlert = true
                    }
                    .foregroundColor(.red)
                    .alert("Вы вышли из аккаунта СитиДрайв", isPresented: $showAlert) {
                        Button("Хорошо") {
                            self.showAlert = false
                        }
                    }
                }
                Section {
                    NavigationLink("Сменить иконку") {
                        IconsListView().environmentObject(appSettings)
                    }
                    #if targetEnvironment(simulator)
                        Button("path") {
                            let realm = try! Realm()
                            print(realm.configuration.fileURL!)
                        }
                    #endif
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
