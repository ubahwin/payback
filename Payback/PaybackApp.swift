//
//  PaybackApp.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

@main
struct PayBackApp: App {
    @AppStorage("isStartView") var isStartView: Bool = true

    var body: some Scene {
        WindowGroup {
            if isStartView {
                StartView()
            } else {
                ContentView()
            }
        }
    }
}
