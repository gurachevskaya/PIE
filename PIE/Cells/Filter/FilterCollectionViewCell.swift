//
//  FilterCollectionViewCell.swift
//  PIE
//
//  Created by Karina on 8/24/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterStateSwitch: UISwitch!
    
    static let nib = UINib(nibName: "FilterCollectionViewCell", bundle: nil)
}
