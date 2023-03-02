//
//  UIView+Extensions.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 28.02.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
}
