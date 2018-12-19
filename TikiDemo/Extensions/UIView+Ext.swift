//
//  UIView+Ext.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit

extension UIView {
    
    public func setCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    public func setCircleView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
