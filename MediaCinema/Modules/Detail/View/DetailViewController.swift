//
//  DetailViewController.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 04/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol {

	var presenter: DetailPresenterProtocol

	init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "DetailViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }

}
