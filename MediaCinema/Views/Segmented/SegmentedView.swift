//
//  SegmentedCollectionView.swift
//  MediaCinema
//
//  Created by MacBook Pro on 29/01/2023.
//

import UIKit

class SegmentedView: UIView {
    
    var collectionView: BaseCollectionView!
    var dataSource: [String] = ["abcd", "abc12312113", "abc", "abc", "abc", "abc", "abc", "abc"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        collectionView = BaseCollectionView.createWith(SegmentedCollectionViewCell.self)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(54)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewFlowLayout = CollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: 16, height: 1)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    
}

extension SegmentedView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCollectionViewCell.className, for: indexPath) as! SegmentedCollectionViewCell
        cell.lbTitle.text = dataSource[indexPath.row]
        return cell
    }
}
