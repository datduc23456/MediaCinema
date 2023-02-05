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

    @IBOutlet weak var imgClearSearch: UIImageView!
    @IBOutlet weak var lbPlaceHolder: UILabel!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var movieInfoView: MovieInformationView!
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
    var delayValue : Double = 2.0
    var timer:Timer?
    //-MARK: Datasource
    var bannerList: [Movie] = []
    var trendingList: [Movie] = []
    var popularList: [Movie] = []
    var ratingList: [Movie] = []
    var detailListBanner: [MovieDetail] = []
    //
    
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
        segmentedView.didSelectSegmented = { [weak self] genreId in
            guard let `self` = self else { return }
            self.presenter.didSelectGenre(genreId)
        }
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
        tfSearch.returnKeyType = .search
    }
    
    @objc func changedTextFieldValue() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(self.searchAction), userInfo: nil, repeats: false)
    }

    @objc func searchAction() {
        if let query = tfSearch.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            if !query.isEmpty {
                presenter.searchMoviePopular(query)
            } else {
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addGradientViewForBackground()
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewBanner {
            return bannerList.count
        } else if collectionView == collectionViewMovieWithGenre {
            return popularList.count
        } else if collectionView == collectionViewMovieTrending {
            return trendingList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieBannerCollectionViewCell.className, for: indexPath) as! MovieBannerCollectionViewCell
            let movie = bannerList[indexPath.row]
            cell.imgBanner.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.posterPath)"))
            return cell
        } else if collectionView == collectionViewMovieWithGenre {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            
            cell.viewRating.isHidden = true
            let movie = popularList[indexPath.row]
            cell.configCell(movie)
            return cell
        } else if collectionView == collectionViewMovieTrending {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            let movie = trendingList[indexPath.row]
            cell.viewFavorite.isHidden = false
            cell.configCell(movie)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className, for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = .none
        let movie = ratingList[indexPath.row]
        cell.configCell(movie, index: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

extension MovieViewController: CollectionViewPagingLayoutDelegate {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        let movie = self.bannerList[currentPage]
        if let movieDetail = self.detailListBanner.first(where: {$0.id == movie.id }) {
            self.movieInfoView.fillInfo(movieDetail)
        }
        pageControl.progress = Double(currentPage)
    }
}
