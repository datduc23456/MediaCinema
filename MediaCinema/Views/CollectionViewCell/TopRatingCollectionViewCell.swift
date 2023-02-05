//
//  TopRatingCollectionViewCell.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 02/02/2023.
//

import UIKit

class TopRatingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imgAvatar3: UIImageView!
    @IBOutlet weak var imgAvatar2: UIImageView!
    @IBOutlet weak var imgAvatar1: UIImageView!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
        outerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        outerView.layer.shadowOffset = CGSize(width: 0.8, height: 8.0)
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowRadius = 3
        outerView.layer.masksToBounds = false
        outerView.layer.cornerRadius = 4.0
        outerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        lbNumber.layer.shadowOffset = CGSize(width: 0.8, height: 8.0)
        lbNumber.layer.shadowOpacity = 0.2
        lbNumber.layer.shadowRadius = 3
        lbNumber.layer.masksToBounds = false
        lbNumber.layer.cornerRadius = 4.0
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        if let payload = payload as? Movie {
            self.payload = payload
            lbNumber.text = "\(self.tag + 1)"
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.originalTitle
            lbVoteAvg.text = "\(payload.voteAverage)"
            lbGenres.text = payload.overview
            lbYear.text = CommonUtil.getYearFromDate(payload.releaseDate)
            lbRating.text = "\(DTPBusiness.shared.roundRating(Double(payload.voteCount))) rating"
        }
    }
}
