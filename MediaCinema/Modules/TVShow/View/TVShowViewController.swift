//
//  TVShowViewController.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit

class TVShowViewController: BaseViewController, TVShowViewProtocol {

    @IBOutlet weak var seeAllBotttomView: BottomButtonView!
    @IBOutlet weak var viewCollectionViewContainer: UIView!
    @IBOutlet weak var collectionViewTrendingMovie: UICollectionView!
    @IBOutlet weak var collectionViewPopularMovie: UICollectionView!
    @IBOutlet weak var viewTrendingMovie: UIView!
    @IBOutlet weak var viewPopularMovie: UIView!
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
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGradientViewForBackground()
    }
}
