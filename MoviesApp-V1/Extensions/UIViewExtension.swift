//
//  UIViewExtension.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/13/20.
//

import UIKit

extension UIView {
    func gradient(firstColor: UIColor, secondColor: UIColor){
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        gradientMaskLayer.colors = [firstColor.cgColor,secondColor.cgColor]
        gradientMaskLayer.locations = [0.0,0.4]
        gradientMaskLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientMaskLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientMaskLayer.cornerRadius = 10
        layer.insertSublayer(gradientMaskLayer, at: 0)
    }
}
