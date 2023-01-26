//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
