//
//  MovieViewController+Ext.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 31/01/2023.
//

import UIKit
import SnapKit

extension MovieViewController {
    func configView() {
        segmentedView = SegmentedView()
        segmentedView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        stackView.addArrangedSubview(segmentedView)
    }
    
    func getGenreListDone() {
        let genreList = DTPBusiness.shared.listGenres
        segmentedView.dataSource = genreList.map({$0.name})
    }
}
