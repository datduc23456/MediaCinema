//
//  ImageCollectionViewCell.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 04/02/2023.
//

import UIKit

class ImageCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var icPlay: UIImageView!
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    var isSelect: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer {
            if let movie = self.payload as? Movie {
                self.didTapAction?(movie)
            }
        }
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        self.payload = payload
        if let movie = payload as? Movie {
            imgThumbnail.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.backdropPath)"))
        }
    }
    
    func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false, isSelected: Bool = false) {
        if let movie = payload as? Movie {
            configCell(movie, isNeedFixedLayoutForIPad: isNeedFixedLayoutForIPad)
            isSelect = isSelected
            if isSelected {
                viewGradient.isHidden = true
                icPlay.isHidden = true
            } else {
                viewGradient.isHidden = false
                icPlay.isHidden = false
            }
        }
    }
}
