//
//  MovieCollectionViewCell.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 02/02/2023.
//

import UIKit

class MovieCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var viewRating: RatingHorizontalView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumbnail.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        imgThumbnail.layer.shadowOffset = CGSize(width: 0.8, height: 8.0)
        imgThumbnail.layer.shadowOpacity = 0.2
        imgThumbnail.layer.shadowRadius = 3
        imgThumbnail.layer.masksToBounds = false
        imgThumbnail.layer.cornerRadius = 4.0
    }

}
