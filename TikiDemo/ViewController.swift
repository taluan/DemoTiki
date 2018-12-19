//
//  ViewController.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import MBProgressHUD

enum CellType {
    case HotKeyword
    case History
    
    public func headerTitle() -> String {
        switch self {
        case .HotKeyword:
            return "Từ khóa hot"
        case .History:
            return "Lịch sử tìm kiếm"
        }
    }
    
    public func rowHeight() -> CGFloat {
        switch self {
        case .HotKeyword:
            return 176
        case .History:
            return 60
        }
    }
    
    public func isHideRightButton() -> Bool {
        switch self {
        case .HotKeyword:
            return true
        case .History:
            return false
        }
    }
}

public let KeywordTableCellIdentifier = "KeywordTableViewCellIdentifier"
public let KeywordHeaderIdentifier = "KeywordHeaderIdentifier"
class ViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var cancelWidthConstraint: NSLayoutConstraint!

    var tableSections:[CellType] = [.HotKeyword, .History]
    var hotKeywords:[KeywordModel] = []
    var histories: [KeywordObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupViews()
        self.loadHotKeywords()
        self.loadHistoryKeywords()
    }
    
    private func setupViews() {
        self.searchTextField.setCornerRadius(radius: 3)
        let searchIconView = UIImageView(image: UIImage(named: "search_icon"))
        searchIconView.frame = CGRect(x: 0, y: 0, width: self.searchTextField.frame.size.height, height: self.searchTextField.frame.size.height)
        searchIconView.contentMode = .center
        self.searchTextField.leftView = searchIconView
        self.searchTextField.leftViewMode = .always
        
        self.tableView.register(UINib(nibName: "KeywordTableViewCell", bundle: nil), forCellReuseIdentifier: KeywordTableCellIdentifier)
        self.tableView.register(UINib(nibName: "KeywordHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: KeywordHeaderIdentifier)
    }
    
    func addKeywordToHistory(keyword: String) {
        if keyword != "" {
            DBManager.Shared.addKeyword(keyword: KeywordObject(keyword: keyword))
            self.searchTextField.text = ""
            self.loadHistoryKeywords()
        }
    }
    
    func loadHotKeywords() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIClient.Shared.getHotKeywords { (keywords, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let _ = error {
                self.showAlert(title: nil, message: "Get data failed!")
            } else {
                self.hotKeywords = keywords
                self.tableView.reloadData()
            }
        }
    }
    
    func loadHistoryKeywords() {
        self.histories = DBManager.Shared.getHistoryKeywords()
        self.tableView.reloadData()
    }
    
    @objc func clearKeywordHistory() {
        self.histories.removeAll()
        DBManager.Shared.clearAllHistory()
        self.tableView.reloadData()
    }

    @IBAction func didTouchCancelButton() {
        self.searchTextField.resignFirstResponder()
        self.searchTextField.text = ""
    }

}

//MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.addKeywordToHistory(keyword: text)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cancelWidthConstraint.constant = 60
        self.cancelButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.cancelWidthConstraint.constant = 16
        self.cancelButton.isHidden = true
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.histories.count > 0 ? 2 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordTableCellIdentifier, for: indexPath) as! KeywordTableViewCell
        cell.keywords = (self.tableSections[indexPath.section] == .HotKeyword ? self.hotKeywords : self.histories)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: KeywordHeaderIdentifier) as! KeywordHeaderView
        header.headerTitleLabel.text = self.tableSections[section].headerTitle()
        header.rightButton.isHidden = self.tableSections[section].isHideRightButton()
        if self.tableSections[section] == .History {
            header.rightButton.addTarget(self, action: #selector(self.clearKeywordHistory), for: .touchUpInside)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableSections[indexPath.section].rowHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
   
}
