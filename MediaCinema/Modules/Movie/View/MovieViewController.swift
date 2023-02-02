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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: CHIPageControlJaloro!
    @IBOutlet weak var collectionViewBanner: UICollectionView!
    
    var headerTopRating: HeaderView!
    var headerTrending: HeaderView!
    var collectionViewMovieTrending: UICollectionView!
    var collectionViewMovieWithGenre: UICollectionView!
    var tableViewTopRating: UITableView!
    var allCategoryBtnView: BottomButtonView!
    var seeAllTopRatingBtnView: BottomButtonView!
    var segmentedView: SegmentedView!
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
        configView()
        collectionViewBanner.registerCell(for: MovieBannerCollectionViewCell.className)
        tableViewTopRating.registerCell(for: MovieTableViewCell.className)
        collectionViewBanner.delegate = self
        collectionViewBanner.dataSource = self
        collectionViewMovieWithGenre.delegate = self
        collectionViewMovieWithGenre.dataSource = self
        collectionViewMovieTrending.delegate = self
        collectionViewMovieTrending.dataSource = self
        tableViewTopRating.delegate = self
        tableViewTopRating.dataSource = self
        collectionViewBanner.isPagingEnabled = true
        collectionViewBanner.dataSource = self
        let layout = CollectionViewPagingLayout()
        collectionViewBanner.collectionViewLayout = layout
        layout.delegate = self
        collectionViewBanner.showsHorizontalScrollIndicator = false
        collectionViewBanner.clipsToBounds = false
        collectionViewBanner.backgroundColor = .clear
        collectionViewMovieWithGenre.showsHorizontalScrollIndicator = false
        collectionViewMovieWithGenre.clipsToBounds = false
        collectionViewMovieWithGenre.backgroundColor = .clear
        presenter.view = self
        presenter.viewDidLoad()
        pageControl.elementWidth = (CommonUtil.SCREEN_WIDTH - 32) / 5
        let _: MovieNavigationView = initCustomNavigation(.movie)
//        addGradientViewForBackground()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addGradientViewForBackground()
        print("abc: \(CommonUtil.SCREEN_WIDTH)")
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewBanner {
            return 5
        } else if collectionView == collectionViewMovieWithGenre {
            return 10
        } else if collectionView == collectionViewMovieTrending {
            return 6
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieBannerCollectionViewCell.className, for: indexPath)
            return cell
        } else if collectionView == collectionViewMovieWithGenre {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            cell.viewRating.isHidden = true
//            cell.imgThumbnail.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: 8), radius: 3, cornerRadius: 8)
            return cell
        } else if collectionView == collectionViewMovieTrending {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

extension MovieViewController: CollectionViewPagingLayoutDelegate {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        pageControl.progress = Double(currentPage)
    }
}
