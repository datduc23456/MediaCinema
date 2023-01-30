//
//  MovieBannerCollectionViewCell.swift
//  MediaCinema
//
//  Created by MacBook Pro on 30/01/2023.
//

import UIKit
import CollectionViewPagingLayout

class MovieBannerCollectionViewCell: UICollectionViewCell, StackTransformView {
    var stackOptions: StackTransformViewOptions {
        var options = StackTransformViewOptions.layout(.perspective)
        options.blurEffectEnabled = true
        options.blurEffectStyle = .light
        return options
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
