//
//  UIApplication+.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/16/25.
//

import UIKit

extension UIApplication {
    static var screenWidth: CGFloat {
        guard let windowScene = shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return UIScreen.main.bounds.width
        }
        return window.bounds.width
    }
}
