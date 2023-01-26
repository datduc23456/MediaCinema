//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit

extension UITableView {
    func registerCell(for id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }
    
    func scrollToTop(animated: Bool) {
        guard numberOfSections > 0 else { return }
        if numberOfRows(inSection: 0) > 0 {
    
            scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
        }
        setContentOffset(.zero, animated: false)
    }
}
