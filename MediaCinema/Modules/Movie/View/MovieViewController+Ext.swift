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
            $0.height.equalTo(76)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        separatorView.snp.makeConstraints {
            $0.height.equalTo(6)
        }
        collectionViewMovieWithGenre = BaseCollectionBuilder().withCell(MovieCollectionViewCell.self)
            .withItemSize(CGSize(width: 105, height: 183))
            .withSpacingInRow(8)
            .withScrollDirection(.horizontal)
            .build()
        collectionViewMovieWithGenre.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewMovieWithGenre.snp.makeConstraints {
            $0.height.equalTo(183)
        }
        tableViewTopRating = UITableView()
        tableViewTopRating.snp.makeConstraints {
            $0.height.equalTo(417)
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
}
