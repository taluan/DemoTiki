//
//  UIImageView+Ext.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    public func setImageWithURL(URL: URL?, placeholderImage: UIImage? = nil) {
        if let imageURL = URL {
            sd_setImage(with: imageURL as URL, placeholderImage: placeholderImage)
        } else {
            self.image = nil
        }
    }
}
