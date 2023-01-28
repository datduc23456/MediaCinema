//
//  MovieViewController.swift
//  MediaCinema
//
//  Created by đạt on 28/01/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, MovieViewProtocol {

    @IBOutlet weak var viewTest: UIView!
    var presenter: MoviePresenterProtocol

	init(presenter: MoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "MovieViewController", bundle: nil)
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
        _ = viewTest.linearGradientBackground(angleInDegs: 180, colors: [UIColor(hex: "#B5ADE4").cgColor, UIColor(hex: "#1EB3CF").cgColor])
    }
}
