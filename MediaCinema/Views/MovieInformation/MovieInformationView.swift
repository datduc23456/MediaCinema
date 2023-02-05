//
//  MovieInformationView.swift
//  MediaCinema
//
//  Created by MacBook Pro on 30/01/2023.
//

import UIKit

class MovieInformationView: BaseCustomView {

    @IBOutlet weak var lbInfomation: UILabel!
    @IBOutlet weak var lbDirector: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ratingView: RatingVerticalView!
    @IBOutlet weak var lbCountry: UILabel!
    
    func fillInfo(_ movie: MovieDetail) {
        lbName.text = movie.movieName
        lbInfomation.text = DTPBusiness.shared.getMovieInfoString(movie)
        var director = ""
        if movie.isTVShow() {
            director = (movie.credits.crew.first(where: { $0.job == "Producer"})?.name).isNil(value: "")
        } else {
            director = (movie.credits.crew.first(where: { $0.job == "Director"})?.name).isNil(value: "")
        }
        lbDirector.text = director
        if let country = movie.productionCountries.first {
            lbCountry.text = "(\(country.name))"
        }
        ratingView.lbRating.text = DTPBusiness.shared.roundVote(movie.voteAverage)
    }
}
