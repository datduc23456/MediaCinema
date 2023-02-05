//
//  TVShowPresenter.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import Foundation

// MARK: View -
protocol TVShowViewProtocol: AnyObject {
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowTrending(_ response: MovieResponse)
    func getTVShowLastest(_ response: MovieResponse)
    func getMovieDetail(_ response: MovieDetail)
}

// MARK: Presenter -
protocol TVShowPresenterProtocol: AnyObject {
	var view: TVShowViewProtocol? { get set }
    func viewDidLoad()
    func getMovieDetail(_ id: Int)
}

class TVShowPresenter: TVShowPresenterProtocol {

    weak var view: TVShowViewProtocol?

    func viewDidLoad() {
        getTVShowPopular()
        getTVShowTrending()
        getTVShowLastest()
    }
    
    func getTVShowPopular() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowPopular(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getTVShowPopular(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowTrending() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.trendingTvShow(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getTVShowTrending(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowLastest() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowTopRate(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getTVShowLastest(response)
            if let firstMovie = response.results.first {
                self.getMovieDetail(firstMovie.id)
            }
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getMovieDetail(_ id: Int) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.TVshowDetail(id), isShowHUD: true, successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getMovieDetail(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
}
