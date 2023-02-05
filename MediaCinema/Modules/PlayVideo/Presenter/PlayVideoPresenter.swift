//
//  PlayVideoPresenter.swift
//  MediaCinema
//
//  Created by đạt on 05/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import Foundation

// MARK: View -
protocol PlayVideoViewProtocol: AnyObject {

}

// MARK: Presenter -
protocol PlayVideoPresenterProtocol: AnyObject {
	var view: PlayVideoViewProtocol? { get set }
    func viewDidLoad()
}

class PlayVideoPresenter: PlayVideoPresenterProtocol {

    weak var view: PlayVideoViewProtocol?

    func viewDidLoad() {

    }
}
