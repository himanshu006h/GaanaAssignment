//
//  Top50CollectionCell.swift
//  GaanaAssignment
//
//  Created by Himanshu Saraswat on 27/07/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class Top50CollectionCell: UICollectionViewCell {

    @IBOutlet weak var trackImage: AsyncImageView!
    @IBOutlet weak var trackName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(detail: Tracks) {
        guard let urlStringValue = detail.atw else { return }
        self.trackName.text = detail.name
        trackImage.loadImage(urlString: urlStringValue)
    }

}
