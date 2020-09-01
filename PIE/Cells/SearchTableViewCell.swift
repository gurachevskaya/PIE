//
//  SearchTableViewCell.swift
//  PIE
//
//  Created by Karina on 9/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
        let backgroundView = UIView()
        self.selectedBackgroundView = backgroundView
        self.selectedBackgroundView?.layer.cornerRadius = 5.0
        selectedBackgroundView?.backgroundColor = .lightGray
       }

    
}
