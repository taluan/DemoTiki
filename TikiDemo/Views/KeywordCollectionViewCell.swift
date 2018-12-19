//
//  KeywordCollectionViewCell.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit

private let MAX_LENGTH_BOX_CONTENT: CGFloat = 121.0
class KeywordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var keywordBoxView: UIView!
    @IBOutlet weak var keywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.keywordBoxView.setCornerRadius(radius: 5)
    }
    
    func configCellWithData(_ data: Any?) {
        if let keyword = data as? KeywordModel {
            self.iconImageView.setImageWithURL(URL: URL(string: keyword.icon), placeholderImage: UIImage(named: "image_placeholder"))
            self.keywordLabel.text = keyword.keyword
        } else if let history = data as? KeywordObject {
            self.keywordLabel.text = history.keyword
            self.iconImageView.isHidden = true
        }
        
    }
    
    func getCellSizeWithHeight(_ height: CGFloat, _ data: Any) -> CGSize {
        var string = ""
        if let keyword = data as? KeywordModel {
            string = keyword.keyword
        } else if let history = data as? KeywordObject {
            string = history.keyword
        }
        var width: CGFloat = MAX_LENGTH_BOX_CONTENT
        if let index = string.splitSentenceIndex() {
            let line1 = String(string.prefix(upTo: index))
            let line2 = String(string.suffix(from: index))
            let width1 = line1.width(withConstraintedHeight: 50, font: self.keywordLabel.font)
            let width2 = line2.width(withConstraintedHeight: 50, font: self.keywordLabel.font)
            width = (width1 > width2 ? width1 : width2) + 32
        } else {
            width = string.width(withConstraintedHeight: 50, font: self.keywordLabel.font) + 32
        }
        
        return CGSize(width: (width > MAX_LENGTH_BOX_CONTENT ? width : MAX_LENGTH_BOX_CONTENT), height: height)
    }

}
