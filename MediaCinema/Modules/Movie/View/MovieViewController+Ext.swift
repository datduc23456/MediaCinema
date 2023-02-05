//
//  MovieViewController+Ext.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 31/01/2023.
//

import UIKit
import SnapKit

extension MovieViewController {
    fileprivate func configPopularMovieView() {
        segmentedView = SegmentedView()
        segmentedView.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        allCategoryBtnView = BottomButtonView()
        allCategoryBtnView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        separatorView.snp.makeConstraints {
            $0.height.equalTo(6)
        }
        collectionViewMovieWithGenre = BaseCollectionBuilder().withCell(MovieCollectionViewCell.self)
            .withItemSize(CGSize(width: 105, height: 200))
            .withSpacingInRow(8)
            .withScrollDirection(.horizontal)
            .build()
        collectionViewMovieWithGenre.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewMovieWithGenre.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        stackView.addArrangedSubview(segmentedView)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(collectionViewMovieWithGenre)
        stackView.addArrangedSubview(allCategoryBtnView)
    }
    
    fileprivate func configTopRatingView() {
        headerTopRating = HeaderView()
        headerTopRating.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        seeAllTopRatingBtnView = BottomButtonView()
        seeAllTopRatingBtnView.snp.makeConstraints {
            $0.height.equalTo(76)
        }
        tableViewTopRating = UITableView()
        tableViewTopRating.snp.makeConstraints {
            $0.height.equalTo(387)
        }
        headerTopRating.contentView.backgroundColor = UIColor(hex: "#E9E9E9").withAlphaComponent(0.4)
        tableViewTopRating.backgroundColor = UIColor(hex: "#E9E9E9").withAlphaComponent(0.4)
        seeAllTopRatingBtnView.contentView.backgroundColor = UIColor(hex: "#E9E9E9").withAlphaComponent(0.4)
//        seeAllTopRatingBtnView.conte
        stackView.addArrangedSubview(headerTopRating)
        stackView.addArrangedSubview(tableViewTopRating)
        stackView.addArrangedSubview(seeAllTopRatingBtnView)
    }
    
    fileprivate func configTrendingView() {
        headerTrending = HeaderView()
        headerTrending.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        collectionViewMovieTrending = BaseCollectionBuilder().withCell(MovieCollectionViewCell.self)
            .withEvenly(spacing: 8, heightForItem: 200, numberOfColumn: 3)
//            .withItemSize(CGSize(width: 90, height: 200))
            
            .withScrollDirection(.vertical)
            .build()
//        collectionViewMovieTrending.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewMovieTrending.snp.makeConstraints {
            $0.height.equalTo(422)
        }

        stackView.addArrangedSubview(headerTrending)
        stackView.addArrangedSubview(collectionViewMovieTrending)
    }
    
    func configView() {
        configPopularMovieView()
        configTopRatingView()
        configTrendingView()
    }
    
    
    
    func getGenreListDone() {
        let genreList = DTPBusiness.shared.listGenres
        segmentedView.dataSource = genreList.map({$0.name})
    }
    
    func getMoviePopular(_ response: MovieResponse) {
        let listMovie = response.results
        let first5 = Array(listMovie.prefix(5))
//        self.collectionViewBanner
        bannerList = first5
        for movie in first5 {
            presenter.getMovieDetailForBanner(movie.id)
        }
        collectionViewBanner.reloadData()
    }
    
    func getMoviePopularWithGenre(_ response: MovieResponse) {
        popularList = response.results
        collectionViewMovieWithGenre.reloadData()
    }
    
    func getTopRate(_ response: MovieResponse) {
        let listMovie = response.results
        let first3 = Array(listMovie.prefix(3))
        ratingList = first3
        tableViewTopRating.reloadData()
    }
    
    func getTrending(_ response: MovieResponse) {
        let listMovie = response.results
        let first6 = Array(listMovie.prefix(6))
        trendingList = first6
        collectionViewMovieTrending.reloadData()
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        
    }
    
    func getMovieDetailForBanner(_ response: MovieDetail) {
        detailListBanner.append(response)
    }
}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lbPlaceHolder.isHidden = true
        imgClearSearch.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            lbPlaceHolder.isHidden = false
            imgClearSearch.isHidden = true
        } else {
            imgClearSearch.isHidden = false
        }
    }
}
