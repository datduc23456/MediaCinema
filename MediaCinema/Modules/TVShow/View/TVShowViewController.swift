//
//  TVShowViewController.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit

class TVShowViewController: BaseViewController, TVShowViewProtocol {

	var presenter: TVShowPresenterProtocol

	init(presenter: TVShowPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "TVShowViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGradientViewForBackground()
    }
}
