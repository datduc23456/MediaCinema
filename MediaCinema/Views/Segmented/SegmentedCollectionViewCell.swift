//
//  SegmentedCollectionViewCell.swift
//  MediaCinema
//
//  Created by đạt on 28/01/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit
import Kingfisher

class SegmentedCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var viewBackgroundImage: UIView!
    
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var isHeightCalculated: Bool = false
    var genre: Genre!
    var isSelect: Bool = false {
        didSet {
            if self.isSelect {
                self.selected()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
    }
    
    override func prepareForReuse() {
        
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        self.payload = payload
        if let payload = payload as? Genre {
            self.genre = payload
            lbTitle.text = payload.name
        } else if let string = payload as? String {
            lbTitle.text = string
        }
    }
    
    func configCell(_ payload: Any, isSelected: Bool) {
        self.configCell(payload)
        self.isSelect = isSelected
        if isSelected {
            selected()
        } else {
            unsected()
        }
    }
    
    func selected() {
//        DTPBusiness.shared.genreSelectedId = genre.id
        viewSeparator.isHidden = false
//        lbTitle.font = CommonUtil.getAppFontBold(14)
        lbTitle.textColor = .black
    }
    
    func unsected() {
//        lbTitle.font = CommonUtil.getAppFontRegular(16)
        viewSeparator.isHidden = true
        lbTitle.textColor = UIColor(hex: "#909090")
    }
}

extension String {
    // hàm tính chiều dài string theo hàng dọc
    func estimateHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    // hàm tính chiều dài string theo hàng ngang
    func estimateWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
