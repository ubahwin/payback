//
//  AppSettings.swift
//  Payback
//
//  Created by Иван Вдовин on 07.03.2023.
//

import Foundation
import UIKit

public class AppSettings: ObservableObject {
    @Published public var iconIndex: Int = 0
    
    public private(set) var icons: [Icon] = []
    public var currentIconName: String? {
        UIApplication.shared.alternateIconName
    }

    public init() {
        fetchIcons()
    }

    public func fetchIcons() {
        if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String : Any] {

            if let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String : Any],
               let iconFileName = (primaryIcon["CFBundleIconFiles"] as? [String])?.first {
                let displayName = (primaryIcon["CFBundleIconName"] as? String) ?? ""
                icons.append(
                    Icon(
                        displayName: displayName,
                        iconName: nil,
                        image: UIImage(named: iconFileName))
                )
            }
            
            if let alternateIcons = bundleIcons["CFBundleAlternateIcons"] as? [String : Any] {
                alternateIcons.forEach { iconName, iconInfo in
                    if let iconInfo = iconInfo as? [String : Any],
                       let iconFileName = (iconInfo["CFBundleIconFiles"] as? [String])?.first {
                        icons.append(
                            Icon(
                                displayName: iconName,
                                iconName: iconName,
                                image: UIImage(named: iconFileName))
                        )
                    }
                }
            }
        }

        iconIndex = icons.firstIndex(where: { icon in
            return icon.iconName == currentIconName
        }) ?? 0
    }
}

public struct Icon {
    public let displayName: String
    public let iconName: String?
    public let image: UIImage?
}
