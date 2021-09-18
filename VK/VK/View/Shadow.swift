//
//  Shadow.swift
//  VK
//
//  Created by Михаил Чертов on 13.08.2021.
//

import UIKit

 class Shadow: UIView {
   
    
    @IBInspectable var shadowOpacity: CGFloat = 0.75 {
        didSet {
            self.updateOpacity()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 20 {
        didSet {
            self.updateRadius()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 10, height: 20) {
        didSet {
            self.updateOffset()
        }
    }
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            self.updateColor()
        }
    }
    
    
    override static var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
     func updateOpacity() {
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
    
     func updateRadius() {
        self.layer.shadowRadius = shadowRadius
    }
    
     func updateOffset() {
        self.layer.shadowOffset = shadowOffset
    }
    
     func updateColor() {
        self.layer.shadowColor = self.shadowColor.cgColor
    }
    
}

