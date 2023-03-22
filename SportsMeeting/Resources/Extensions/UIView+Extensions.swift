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
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // For insert layer in Foreground
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
     let gradient = CAGradientLayer()
     gradient.frame = frame
     gradient.colors = colors.map{$0.cgColor}
     self.layer.addSublayer(gradient)
    }
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
     let gradient = CAGradientLayer()
     gradient.frame = frame
     gradient.colors = colors.map{$0.cgColor}
     self.layer.insertSublayer(gradient, at: 0)
    }
}
