//
//  GaanaTableViewCell.swift
//  GaanaAssignment
//
//  Created by Himanshu Saraswat on 27/07/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class GaanaTableViewCell: UITableViewCell {

    var sectionDetails: Sections?
    
    struct Constants {
        static let cellIdentifier = "Top50CollectionCell"
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerGaanaCell()
    }
    
    func registerGaanaCell() {
        self.collectionView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    func configureCell(sectionData: Sections) {
        self.sectionDetails = sectionData
    }
}

extension GaanaTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionDetails?.tracks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath as IndexPath) as? Top50CollectionCell,
            let trackDetails = self.sectionDetails?.tracks else {
                return UICollectionViewCell()
        }
        cell.configure(detail: trackDetails[indexPath.row])
        return cell
    }
}
