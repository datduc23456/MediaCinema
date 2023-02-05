//
//  MovieTableViewCell.swift
//  MediaCinema
//
//  Created by MacBook Pro on 02/02/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lbVoteCount: UILabel!
    @IBOutlet weak var ava3: UIImageView!
    @IBOutlet weak var ava2: UIImageView!
    @IBOutlet weak var ava1: UIImageView!
    @IBOutlet weak var lbInformation: UILabel!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ava1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ava1.layer.shadowOffset = CGSize(width: 0.8, height: 6.0)
        ava1.layer.shadowOpacity = 0.5
        ava1.layer.shadowRadius = 3
        ava1.layer.masksToBounds = false
        ava1.layer.cornerRadius = 4.0
        
        ava2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ava2.layer.shadowOffset = CGSize(width: 0.8, height: 6.0)
        ava2.layer.shadowOpacity = 0.5
        ava2.layer.shadowRadius = 3
        ava2.layer.masksToBounds = false
        ava2.layer.cornerRadius = 4.0
        
        ava3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ava3.layer.shadowOffset = CGSize(width: 0.8, height: 6.0)
        ava3.layer.shadowOpacity = 0.5
        ava3.layer.shadowRadius = 3
        ava3.layer.masksToBounds = false
        ava3.layer.cornerRadius = 4.0
        
        outerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        outerView.layer.shadowOffset = CGSize(width: 0.8, height: 10.0)
        outerView.layer.shadowOpacity = 0.5
        outerView.layer.shadowRadius = 3
        outerView.layer.masksToBounds = false
        outerView.layer.cornerRadius = 4.0
        lbNumber.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        lbNumber.layer.shadowOffset = CGSize(width: 0.8, height: 4.0)
        lbNumber.layer.shadowOpacity = 0.6
        lbNumber.layer.shadowRadius = 3
        lbNumber.layer.masksToBounds = false
        lbNumber.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(_ movie: Movie, index: Int) {
        lbNumber.text = "\(index)"
        imgThumbnail.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.posterPath)"))
        lbName.text = movie.originalTitle
        getMovieDetail(movie.id)
        let voteCount = DTPBusiness.shared.roundRating(Double(movie.voteCount))
        lbVoteCount.text = "\(voteCount) rating"
    }
    
    func getMovieDetail(_ id: Int) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.detail(id), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            if let country = response.productionCountries.first {
                self.lbCountry.text = country.name
                self.lbInformation.text = DTPBusiness.shared.getMovieInfoString(response)
            }
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
}
