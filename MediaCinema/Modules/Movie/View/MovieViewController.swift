//
//  MovieViewController.swift
//  MediaCinema
//
//  Created by đạt on 28/01/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class MovieViewController: BaseViewController, MovieViewProtocol {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: CHIPageControlJaloro!
    @IBOutlet weak var collectionViewBanner: UICollectionView!

    var presenter: MoviePresenterProtocol

	init(presenter: MoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: MovieViewController.className, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewBanner.registerCell(for: MovieBannerCollectionViewCell.className)
        collectionViewBanner.delegate = self
        collectionViewBanner.dataSource = self
        collectionViewBanner.isPagingEnabled = true
        collectionViewBanner.dataSource = self
        let layout = CollectionViewPagingLayout()
        collectionViewBanner.collectionViewLayout = layout
        layout.delegate = self
        collectionViewBanner.showsHorizontalScrollIndicator = false
        collectionViewBanner.clipsToBounds = false
        collectionViewBanner.backgroundColor = .clear
        presenter.view = self
        presenter.viewDidLoad()
        pageControl.elementWidth = (CommonUtil.SCREEN_WIDTH - 32) / 5
        let _: MovieNavigationView = initCustomNavigation(.movie)
//        addGradientViewForBackground()
        configView()
    }

    override func viewDidAppear(_ animated: Bool) {
        addGradientViewForBackground()
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieBannerCollectionViewCell.className, for: indexPath)
        return cell
    }
}

extension MovieViewController: CollectionViewPagingLayoutDelegate {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        pageControl.progress = Double(currentPage)
    }
}
