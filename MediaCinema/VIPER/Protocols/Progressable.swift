//
//  APIManager.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit
import ProgressHUD

public protocol Progressable {
    func showLoading()
    func showLoading(message: String)
    func hideLoading()
}

extension Progressable where Self: UIViewController {

    public func showLoading() {
        view.endEditing(true)
        ProgressHUD.show()
    }

    public func showLoading(message: String) {
        view.endEditing(true)
        ProgressHUD.show(message)
    }

    public func hideLoading() {
        ProgressHUD.dismiss()
    }
}
