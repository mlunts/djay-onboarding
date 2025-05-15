//
//  UIWindow+Extension.swift
//  djay onboarding
//
//  Created by Marina Lunts on 15.05.25.
//

import UIKit

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                return false
            }
            return windowScene.interfaceOrientation.isLandscape
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
