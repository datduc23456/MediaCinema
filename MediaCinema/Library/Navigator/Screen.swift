//
//  Screen.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit
public protocol Screen {
    var path: String { get }
    var transition: NavigateTransions { get }
    func createViewController(_ payload: Any?) -> UIViewController
}

public enum NavigateTransions: String {
    case replace
    case push
    case present
}

enum AppScreens: String, Screen, CaseIterable {
    case example
    case home
    case tvShow
    case favorite
    case detail
    case statistical
    case addnote
    case popularpeople
    case playvideo
    case search
    case note
    case action
    case genres
    case usernote
    case watchedList
    case season
    case images
    case videos
    case similar
    case setting
    case webView
    case movie
    
    var path: String {
        return rawValue
    }
    
    var transition: NavigateTransions {
        switch self {
        case .playvideo:
            return .present
        default:
            return .push
        }
    }
    
    func createViewController(_ payload: Any? = nil) -> UIViewController {
//        switch self {
//        case .example:
//            return ExampleWireframe.generateModule(payload)
//        case .tvShow:
//            return TVShowWireframe.generateModule(payload)
//        case .favorite:
//            return FavoriteWireframe.generateModule(payload)
//        case .detail:
//            return MovieDetailWireframe.generateModule(payload)
//        case .statistical:
//            return StatisticcalWireframe.generateModule(payload)
//        case .addnote:
//            return AddNoteWireframe.generateModule(payload)
//        case .popularpeople:
//            return PopularPeopleWireframe.generateModule(payload)
//        case .home:
//            return HomeWireframe.generateModule(payload)
//        case .search:
//            return SearchWireframe.generateModule(payload)
//        case .note:
//            return NoteWireframe.generateModule(payload)
//        case .playvideo:
//            return PlayVideoWireframe.generateModule(payload)
//        case .action:
//            return ActionWireframe.generateModule(payload)
//        case .genres:
//            return GenersWireframe.generateModule(payload)
//        case .usernote:
//            return UserNoteWireframe.generateModule(payload)
//        case .watchedList:
//            return WatchedListWireframe.generateModule(payload)
//        case .season:
//            return SeasonWireframe.generateModule(payload)
//        case .images:
//            return ImagesWireframe.generateModule(payload)
//        case .videos:
//            return VideosWireframe.generateModule(payload)
//        case .similar:
//            return SimilarWireframe.generateModule(payload)
//        case .setting:
//            return SettingWireframe.generateModule(payload)
//        case .webView:
//            return WebViewWireframe.generateModule(payload)
//        }
        switch self {
        case .movie:
            let vc = MovieViewController(presenter: MoviePresenter())
            vc.payload = payload
            return vc
        case .tvShow:
            let vc = TVShowViewController(presenter: TVShowPresenter())
            vc.payload = payload
            return vc
        case .playvideo:
            let vc = PlayVideoViewController(presenter: PlayVideoPresenter())
            vc.payload = payload
            return vc
        default:
            return UIViewController()
        }
    }
}
