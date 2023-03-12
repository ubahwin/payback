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
                }
                Section {
                    NavigationLink("Сменить иконку") {
                        IconsListView().environmentObject(appSettings)
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

struct IconsListView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        Form {
            Picker("", selection: $appSettings.iconIndex) {
                ForEach(appSettings.icons.indices, id: \.self) { index in
                    IconRow(icon: appSettings.icons[index])
                    .tag(index)
                }
            }
            .onChange(of: appSettings.iconIndex) { newIndex in
                guard UIApplication.shared.supportsAlternateIcons else {
                    print("Error icon")
                    return
                }
                
                let currentIndex = appSettings.icons.firstIndex(where: { icon in
                    return icon.iconName == appSettings.currentIconName
                }) ?? 0
                guard newIndex != currentIndex else { return }
                let newIconSelection = appSettings.icons[newIndex].iconName
                UIApplication.shared.setAlternateIconName(newIconSelection) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .pickerStyle(.inline)
    }
}

struct IconRow: View {
    let icon: Icon
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: icon.image ?? UIImage())
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .padding(.trailing)
            Text(icon.displayName)
        }
        .padding(8)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

