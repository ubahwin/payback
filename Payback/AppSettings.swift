////
////  AppSettings.swift
////  Payback
////
////  Created by Иван Вдовин on 07.03.2023.
////
//
//import Foundation
//import UIKit
//
//public class AppSettings: ObservableObject {
//    @Published public var iconIndex: Int = 0
//
//    public private(set) var icons: [Icon] = []
//    public var currentIconName: String? {
//        UIApplication.shared.alternateIconName
//    }
//
//    public func fetchIcons() {
//        if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFFBundleIcons") as [String : Any] {
//            if let primaryIcon = bundleIcons["CFFBundlePrimaryIcons"] as? [String : Any],
//               let iconFileName = (primaryIcon["CFFBundleIconsFiles"] as? [String] {
//
//            }
//        }
//    }
//}
//
//public struct Icon {
//    public let displayName: String
//    public let iconName: String?
//    public let image: UIImage?
//}