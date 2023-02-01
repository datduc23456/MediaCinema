//
//  HorizontalCollectionViewFlowLayout.swift
//  MediaCinema
//
//  Created by MacBook Pro on 01/02/2023.
//

import UIKit

class DynamicFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        guard let collectionView = collectionView else { return nil }
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        layoutAttributes.bounds.size.width = collectionWidth - sectionInset.left - sectionInset.right
        return layoutAttributes
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard scrollDirection == .vertical else { return superLayoutAttributes }

        let computedAttributes = superLayoutAttributes.compactMap { layoutAttribute in
            layoutAttribute.representedElementCategory == .cell ?
                layoutAttributesForItem(at: layoutAttribute.indexPath) : layoutAttribute
        }
        return computedAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
}
