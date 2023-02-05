//
//  ImageButton.swift
//  MediaCinema
//
//  Created by Nguyễn Đạt on 04/02/2023.
//

import UIKit

class ImageButton: UIView {

    private var shadowLayer: CAShapeLayer!
    var imageView: UIImageView!
    var label: UILabel!
    
    @IBInspectable public var image: UIImage = UIImage(named: "ic_play")!
    @IBInspectable public var title: String = "" {
        didSet {
            label.text = title
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.backgroundColor = APP_COLOR
        label = UILabel()
        label.textColor = .white
        label.font = CommonUtil.getAppFontRegular(16)
        label.text = title
        self.addSubview(label)
        imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(13)
        }
        
        label.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-22)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            self.layer.masksToBounds = false
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 22).cgPath
            shadowLayer.fillColor = APP_COLOR.cgColor
//            shadowLayer.backgroundColor = APP_COLOR.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1.0, height: 10.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 4
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
//        self.cornerRadius = self.frame.height / 2
    }
}
