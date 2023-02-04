//
//  ImageButton.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 04/02/2023.
//

import UIKit

class ImageButton: UIButton {

    private var shadowLayer: CAShapeLayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.titleLabel?.font = CommonUtil.getAppFontRegular(16)
//        self.backgroundColor = APP_COLOR
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .clear
            config.imagePadding = 5
            self.configuration = config
        } else {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 22).cgPath
            shadowLayer.fillColor = APP_COLOR.cgColor
//            shadowLayer.backgroundColor = APP_COLOR.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 8.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 4
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
//        self.cornerRadius = self.frame.height / 2
    }
}
