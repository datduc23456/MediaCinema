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

}

// MARK: Presenter -
protocol MoviePresenterProtocol: AnyObject {
	var view: MovieViewProtocol? { get set }
    func viewDidLoad()
}

class MoviePresenter: MoviePresenterProtocol {

    weak var view: MovieViewProtocol?

    func viewDidLoad() {
        getGenresList()
    }
    
    func getGenresList() {
        ServiceCore.shared.request(GenreResponse.self, targetType: CoreTargetType.genreList, successBlock: { [weak self] response in
            guard let `self` = self, let view = self.view else { return }
            DTPBusiness.shared.listGenres = response.genres
            
        }, failureBlock: { error in
            
        })
    }
}
