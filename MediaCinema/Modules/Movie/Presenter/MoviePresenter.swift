//
//  MoviePresenter.swift
//  MediaCinema
//
//  Created by đạt on 28/01/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import Foundation

// MARK: View -
protocol MovieViewProtocol: AnyObject {
    func getGenreListDone()
    func getMoviePopular(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTrending(_ response: MovieResponse)
    func getMovieDetail(_ response: MovieDetail)
    func getMoviePopularWithGenre(_ response: MovieResponse)
    func getMovieDetailForBanner(_ response: MovieDetail)
}

// MARK: Presenter -
protocol MoviePresenterProtocol: AnyObject {
	var view: MovieViewProtocol? { get set }
    func viewDidLoad()
    func didSelectGenre(_ index: Int)
    func getMovieDetailForBanner(_ id: Int)
    func searchMoviePopular(_ query: String)
}

class MoviePresenter: MoviePresenterProtocol {

    weak var view: MovieViewProtocol?

    func viewDidLoad() {
        getGenresList()
        getMoviePopular()
        getTrendingMovie()
        getTopRate()
    }
    
    func getMovieDetailForBanner(_ id: Int) {
        getMovieDetail(id, completion: { [weak self] movie in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.view?.getMovieDetailForBanner(movie)
            }
        })
    }
    
    func getGenresList() {
        ServiceCore.shared.request(GenreResponse.self, targetType: CoreTargetType.genreList, successBlock: { [weak self] response in
            guard let `self` = self, let view = self.view else { return }
            DTPBusiness.shared.listGenres = response.genres
            view.getGenreListDone()
            if let genreFirst = response.genres.first {
                self.getMoviePopular(genreFirst.id)
            }
        }, failureBlock: { error in
            
        })
    }
    
    func getMoviePopular() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.popular(1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getMoviePopular(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getTrendingMovie() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.trendingMovie(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getTrending(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getTopRate() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.movieTopRated(1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getTopRate(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getMoviePopular(_ genreId: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviegenreid(genreId: genreId, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getMoviePopularWithGenre(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func getMovieDetail(_ id: Int, completion: @escaping ((MovieDetail)->Void)) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.detail(id), isShowHUD: false, successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getMovieDetail(response)
            completion(response)
        }, failureBlock: { error in
//            self.output?.handleError(error, {})
        })
    }
    
    func searchMoviePopular(_ query: String) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.searchMovie(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.view?.getMoviePopular(response)
        }, failureBlock: { error in
            
        })
    }
    
    func didSelectGenre(_ index: Int) {
        let listGenres = DTPBusiness.shared.listGenres
        let id = listGenres[index].id
        self.getMoviePopular(id)
    }
}
