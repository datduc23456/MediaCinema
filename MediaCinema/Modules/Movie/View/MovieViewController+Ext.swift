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
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        stackView.addArrangedSubview(view)
    }
}
