//
//  FilterCollectionViewCell.swift
//  PIE
//
//  Created by Karina on 8/24/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterStateSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
