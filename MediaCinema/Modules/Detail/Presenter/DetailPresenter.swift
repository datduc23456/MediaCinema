//
//  DetailPresenter.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 04/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import Foundation

// MARK: View -
protocol DetailViewProtocol: AnyObject {

}

// MARK: Presenter -
protocol DetailPresenterProtocol: AnyObject {
	var view: DetailViewProtocol? { get set }
    func viewDidLoad()
}

class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewProtocol?

    func viewDidLoad() {

    }
}
