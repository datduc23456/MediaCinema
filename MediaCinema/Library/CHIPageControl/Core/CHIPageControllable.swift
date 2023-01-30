//
//  CHIPageControllable.swift
//  MediaCinema
//
//  Created by MacBook Pro on 30/01/2023.
//

import Foundation
import CoreGraphics
import UIKit

protocol CHIPageControllable: AnyObject {
    var numberOfPages: Int { get set }
    var currentPage: Int { get }
    var progress: Double { get set }
    var hidesForSinglePage: Bool { get set }
    var borderWidth: CGFloat { get set }

    func set(progress: Int, animated: Bool)
}
