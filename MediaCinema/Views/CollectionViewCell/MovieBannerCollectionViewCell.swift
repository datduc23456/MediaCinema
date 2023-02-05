//
//  MovieBannerCollectionViewCell.swift
//  MediaCinema
//
//  Created by MacBook Pro on 30/01/2023.
//

import UIKit
import CollectionViewPagingLayout

class MovieBannerCollectionViewCell: UICollectionViewCell, StackTransformView {
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var outerView: UIView!
    private var shadowLayer: CAShapeLayer!
    var stackOptions: StackTransformViewOptions {
        var options = StackTransformViewOptions.layout(.perspective)
        options.blurEffectEnabled = true
        options.blurEffectStyle = .light
        options.alphaFactor = 0.4
//        options.stackPosition = CGPoint(x: 0, y: 1)
        return options
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.imgBanner.layer.masksToBounds = true
        imgBanner.layer.cornerRadius = 8
//        imgBanner.cornerRadius = 8
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
////            shadowLayer.fillColor = APP_COLOR.cgColor
////            shadowLayer.backgroundColor = APP_COLOR.cgColor
//            shadowLayer.shadowColor = UIColor.red.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
////            shadowLayer.shadowOffset = CGSize(width: 1.0, height: 4.0)
////            shadowLay
//            shadowLayer.shadowOpacity = 0.2
//            shadowLayer.shadowRadius = 10
//
//            outerView.layer.insertSublayer(shadowLayer, at: 0)
//            //layer.insertSublayer(shadowLayer, below: nil) // also works
//        }
        
    }

}
