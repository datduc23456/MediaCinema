//
//  TVShowPresenter.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import Foundation

// MARK: View -
protocol TVShowViewProtocol: AnyObject {

}

// MARK: Presenter -
protocol TVShowPresenterProtocol: AnyObject {
	var view: TVShowViewProtocol? { get set }
    func viewDidLoad()
}

class TVShowPresenter: TVShowPresenterProtocol {

    weak var view: TVShowViewProtocol?

    func viewDidLoad() {

    }
}
