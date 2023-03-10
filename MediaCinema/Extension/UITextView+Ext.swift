//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation
import UIKit

extension UITextView {
    private struct AssociatedKeys {
        static var isPlaceHolder = "isPlaceHolder"
    }
    
    var isPlaceHolder: Bool? {
        get {
            return  objc_getAssociatedObject(self, &AssociatedKeys.isPlaceHolder) as? Bool
        }

        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.isPlaceHolder, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
