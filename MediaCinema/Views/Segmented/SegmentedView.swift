//
//  SegmentedCollectionView.swift
//  MediaCinema
//
//  Created by MacBook Pro on 29/01/2023.
//

import UIKit

class SegmentedView: UIView {
    
    var collectionView: BaseCollectionView!
    var dataSource: [String] = []
    var selectedIndex: Int = 0
    
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
        collectionView.bounces = false
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(54)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: 16, height: 1)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
}

extension SegmentedView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCollectionViewCell.className, for: indexPath) as! SegmentedCollectionViewCell
        let title = dataSource[indexPath.row]
        cell.configCell(title, isSelected: indexPath.row == selectedIndex)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            self.selectedIndex = indexPath.row
            for cell in collectionView.visibleCells {
                if let segmentedCell = cell as? SegmentedCollectionViewCell {
                    segmentedCell.unsected()
                }
            }
            cell.selected()
        }
        return cell
    }
}
