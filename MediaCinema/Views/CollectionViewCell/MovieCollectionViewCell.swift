//
//  MovieCollectionViewCell.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 02/02/2023.
//

import UIKit

class MovieCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var viewRating: RatingHorizontalView!
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                viewFavorite.backgroundColor = APP_COLOR
            } else {
                viewFavorite.backgroundColor = .black.withAlphaComponent(0.6)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewFavorite.roundCorners(corners: [.bottomRight], radius: 8)
        outerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        outerView.layer.shadowOffset = CGSize(width: 0.8, height: 8.0)
        outerView.layer.shadowOpacity = 0.2
        outerView.layer.shadowRadius = 3
        outerView.layer.masksToBounds = false
        outerView.layer.cornerRadius = 4.0
        viewFavorite.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.isFavorite = !self.isFavorite
        }
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        if let movie = payload as? Movie {
            lbName.text = movie.movieName
            imgThumbnail.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.posterPath)"))
            viewRating.lbRating.text = DTPBusiness.shared.roundVote(movie.voteAverage)
        }
    }

}
