//
//  KeywordTableViewCell.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit

public let KeywordCollectionCellIdentifier = "KeywordCollectionViewCellIdentifier"
class KeywordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var reusedCell = Bundle.main.loadNibNamed("KeywordCollectionViewCell", owner: self, options: nil)![0] as! KeywordCollectionViewCell
    public var keywords: [Any] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib(nibName: "KeywordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KeywordCollectionCellIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension KeywordTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionCellIdentifier, for: indexPath) as! KeywordCollectionViewCell
        cell.keywordBoxView.backgroundColor = UIColor.backgroundColorItem(index: indexPath.row)
        cell.configCellWithData(self.keywords[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return reusedCell.getCellSizeWithHeight(collectionView.frame.size.height, self.keywords[indexPath.row])
    }
    
}
