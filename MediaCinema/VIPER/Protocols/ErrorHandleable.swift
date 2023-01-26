//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation

public protocol ErrorHandleable {
    func handleError(_ error: Error, _ completion: (() -> Void)?)
}
