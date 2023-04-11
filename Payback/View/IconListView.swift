//
//  IconListView.swift
//  Payback
//
//  Created by Иван Вдовин on 10.04.2023.
//

import SwiftUI

struct IconsListView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        Form {
            Picker("Выбор иконки", selection: $appSettings.iconIndex) {
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

