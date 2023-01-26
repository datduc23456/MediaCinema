//
//  TableViewAdjustedHeight.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit

protocol TableViewAdjustedHeightDelegate: AnyObject {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize)
}

class TableViewAdjustedHeight: UITableView {
    
    weak var contentSizeDelegate: TableViewAdjustedHeightDelegate?
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    override var contentSize: CGSize {
        didSet {
            contentSizeDelegate?.didChangeContentSize(self, size: contentSize)
            self.invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
