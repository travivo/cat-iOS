//
//  UIExtensions.swift
//  Cats
//
//  Created by aljon antiola on 10/12/24.
//

import UIKit

extension UIView {

    func applyGradientWithTransparency(startColor: UIColor, endColor: UIColor, startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = [0.0, 1.0]
        
        self.backgroundColor = .clear
        
        // Remove any existing gradient layer if needed
        if let existingLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingLayer.removeFromSuperlayer()
        }
        
        // Insert new gradient layer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}

