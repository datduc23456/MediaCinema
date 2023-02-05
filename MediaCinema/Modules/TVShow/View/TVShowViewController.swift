//
//  TVShowViewController.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit

class TVShowViewController: BaseViewController, TVShowViewProtocol {

    @IBOutlet weak var linearGradientView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var movieInfomationView: MovieInformationView!
    @IBOutlet weak var collectionViewBanner: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var seeAllBotttomView: BottomButtonView!
    @IBOutlet weak var viewCollectionViewContainer: UIView!
    @IBOutlet weak var collectionViewTrendingMovie: UICollectionView!
    @IBOutlet weak var collectionViewPopularMovie: UICollectionView!
    @IBOutlet weak var viewTrendingMovie: UIView!
    @IBOutlet weak var viewPopularMovie: UIView!
    var presenter: TVShowPresenterProtocol
    var selectedBannerIndex: Int = 0
    var movieDetail: MovieDetail?
    
    //-MARK: Datasource
    var bannerList: [Movie] = []
    var trendingList: [Movie] = []
    var popularList: [Movie] = []
    //
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = linearGradientView.linearGradientBackground(angleInDegs: 180, colors: [UIColor(red: 206, green: 148, blue: 248, alpha: 0).cgColor, UIColor(red: 203, green: 152, blue: 243, alpha: 0.89).cgColor, UIColor(hex: "#21C2E0").withAlphaComponent(1).cgColor], locations: [0.032, 0.21, 0.57])
    }
    
    @IBAction func trailerAction(_ sender: Any) {
        if let movieDetail, let video = movieDetail.videos.video.first {
            let vc = AppScreens.playvideo.createViewController(video.key)
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true)
        }
    }
}

extension TVShowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPopularMovie {
            return popularList.count
        } else if collectionView == collectionViewTrendingMovie {
            return trendingList.count
        } else if collectionView == collectionViewBanner {
            return bannerList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewPopularMovie {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            let movie = popularList[indexPath.row]
            cell.viewRating.isHidden = true
            cell.configCell(movie)
            return cell
        } else if collectionView == collectionViewTrendingMovie {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
            let movie = trendingList[indexPath.row]
            cell.viewRating.isHidden = true
            cell.configCell(movie)
            return cell
        } else if collectionView == collectionViewBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as! ImageCollectionViewCell
            let movie = bannerList[indexPath.row]
//            cell.viewRating.isHidden = true
            cell.didTapAction = { [weak self] payload in
                guard let `self` = self else { return }
                if let movie = payload as? Movie {
                    self.backGroundImage.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.posterPath)"))
                    self.selectedBannerIndex = indexPath.row
                    self.presenter.getMovieDetail(movie.id)
                }
                for cell in collectionView.visibleCells {
                    if let bannerCell = cell as? ImageCollectionViewCell {
                        bannerCell.icPlay.isHidden = false
                        bannerCell.viewGradient.isHidden = false
                    }
                }
                self.pageControl.currentPage = indexPath.row
                cell.viewGradient.isHidden = true
                cell.icPlay.isHidden = true
            }
            cell.configCell(movie, isSelected: selectedBannerIndex == indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
