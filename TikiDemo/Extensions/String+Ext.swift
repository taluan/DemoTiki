//
//  String+Ext.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit

public extension String {

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func splitSentenceIndex() -> String.Index? {
        let string = self
        let index = string.index(string.startIndex, offsetBy: (string.count / 2) - 1)
        if string[index] == " " {
            return index
        } else {
            let line1 = String(string.prefix(upTo: index))
            let line2 = String(string.suffix(from: index))
            if let preIndex = line1.lastIndex(of: " "), let nextIndex = line2.firstIndex(of: " ")  {
                if nextIndex.encodedOffset > line1.count - preIndex.encodedOffset {
                    return preIndex
                } else {
                    return String.Index(encodedOffset: line1.count + nextIndex.encodedOffset)
                }
            } else if let preIndex = line1.lastIndex(of: " ") {
                return preIndex
            } else if let nextIndex = line2.firstIndex(of: " ") {
                return String.Index(encodedOffset: line1.count + nextIndex.encodedOffset)
            }
        }
        return nil
    }
}
