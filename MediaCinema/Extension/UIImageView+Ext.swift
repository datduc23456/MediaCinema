//
//  UIImageView+Ext.swift
//  MediaCinema
//
//  Created by MacBook Pro on 04/02/2023.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
    
    func setImageUrlWithPlaceHolder(url: URL?, _ placeHolder: UIImage = UIImage(named: "placeholder")!) {
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
