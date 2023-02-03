//
//  FavoriteButton.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 03/02/2023.
//

import UIKit

class FavoriteButton: UIButton {

    @IBInspectable var active:Bool = false
    var didTap: VoidCallBack?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
        self.setImage(UIImage(named: "ic_heart_selected"), for: .normal)
        self.cornerRadius = self.frame.height / 2
        self.addTapGestureRecognizer {
            self.didTap?()
            self.active = !self.active
            if self.active {
                self.setSelected()
            } else {
                self.setDeselected()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    func setSelected() {
        self.setImage(UIImage(named: "ic_heart_selected"), for: .normal)
    }
    
    // Set the deselcted properties
    func setDeselected() {
        self.setImage(UIImage(named: "ic_heart_unselected"), for: .normal)
    }
}
