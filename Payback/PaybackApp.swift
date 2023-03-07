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

    init() {
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif
    }

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
