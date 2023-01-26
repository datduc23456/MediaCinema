//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

public protocol ViewInterface: AnyObject, Progressable {
    func handleError(_ error: Error)
}

extension ViewInterface {
    func handleError(_ error: Error) {
        
    }
}
