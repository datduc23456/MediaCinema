//
//  TVShowViewController+Ext.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//

import UIKit
import SnapKit

extension TVShowViewController {
    func configView() {
        seeAllBotttomView.button.setTitle("See all", for: .normal)
        seeAllBotttomView.roundCornersVersionT(corners: [.bottomLeft, .bottomRight], radius: 10)
        viewPopularMovie.roundCornersVersionT(corners: [.topLeft], radius: 10)
        viewTrendingMovie.roundCornersVersionT(corners: [.topRight], radius: 10)
        viewSeparator.roundCornersVersionT(corners: [.topRight], radius: 10)
        viewPopularMovie.addTapGestureRecognizer {
            self.viewTrendingMovie.alpha = 0.5
            self.viewPopularMovie.alpha = 1
            self.collectionViewPopularMovie.isHidden = false
            self.collectionViewTrendingMovie.isHidden = true
        }
        viewTrendingMovie.addTapGestureRecognizer {
            self.viewTrendingMovie.alpha = 1
            self.viewPopularMovie.alpha = 0.5
            self.collectionViewPopularMovie.isHidden = true
            self.collectionViewTrendingMovie.isHidden = false
        }
        collectionViewPopularMovie.registerCell(for: MovieCollectionViewCell.className)
        collectionViewPopularMovie.dataSource = self
        collectionViewPopularMovie.delegate = self
        collectionViewPopularMovie.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        collectionViewTrendingMovie.registerCell(for: MovieCollectionViewCell.className)
        collectionViewTrendingMovie.dataSource = self
        collectionViewTrendingMovie.delegate = self
        collectionViewTrendingMovie.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        collectionViewBanner.registerCell(for: ImageCollectionViewCell.className)
        collectionViewBanner.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewBanner.dataSource = self
        collectionViewBanner.delegate = self
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .clear
        pageControl.setFillColor(.white, for: .normal)
        pageControl.setFillColor(APP_COLOR, for: .selected)
        seeAllBotttomView.bottomSpacing.constant = 14
    }
    
    func getTVShowTrending(_ response: MovieResponse) {
        let movie = response.results
        let first3 = Array(movie.prefix(3))
        trendingList = movie
        collectionViewTrendingMovie.reloadData()
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        let movie = response.results
        let first3 = Array(movie.prefix(3))
        popularList = movie
        collectionViewPopularMovie.reloadData()
    }

    func getTVShowLastest(_ response: MovieResponse) {
        let movie = response.results
        let first10 = Array(movie.prefix(10))
        if let firstMovie = first10.first {
            backGroundImage.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(firstMovie.posterPath)"))
        }
        pageControl.numberOfPages = first10.count
        bannerList = first10
        collectionViewBanner.reloadData()
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        movieDetail = response
        movieInfomationView.fillInfo(response)
    }
}
