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
        viewCollectionViewContainer.roundCornersVersionT(corners: [.topRight], radius: 10)
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
    }
}
