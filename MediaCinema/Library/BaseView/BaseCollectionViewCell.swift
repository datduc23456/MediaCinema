//
//  BaseCollectionViewCell.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    var didTapAction: ((Any) -> Void)?
    var payload: Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        self.payload = payload
    }
}
