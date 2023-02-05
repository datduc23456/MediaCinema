//
//  SegmentedCollectionView.swift
//  MediaCinema
//
//  Created by MacBook Pro on 29/01/2023.
//

import UIKit

class SegmentedView: UIView {
    
    var collectionView: BaseCollectionView!
    var dataSource: [String] = [] {
        didSet {
            reloadData()
        }
    }
    var selectedIndex: Int = 0
    var didSelectSegmented: ((Int)->Void) = {_ in}
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
        let collectionViewFlowLayout = CollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 100, height: 54)
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: 16, height: 1)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = BaseCollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewFlowLayout)
        collectionView.registerCell(for: SegmentedCollectionViewCell.className)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(self)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension SegmentedView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentedCollectionViewCell.className, for: indexPath) as! SegmentedCollectionViewCell
        let title = dataSource[indexPath.row]
        cell.configCell(title, isSelected: indexPath.row == selectedIndex)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            self.didSelectSegmented(indexPath.row)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = dataSource[indexPath.row]
        return CGSize(width: title.estimateWidth(withConstrainedHeight: 34, font: CommonUtil.getAppFontRegular(16)) + 16, height: 34)
    }
}
