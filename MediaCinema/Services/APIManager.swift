//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Alamofire

class APIManager {
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 30
      return Session(configuration: configuration)
    }()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.urlCache = nil
    }
}

