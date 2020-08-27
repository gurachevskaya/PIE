//
//  CollectionViewCell.swift
//  PIE
//
//  Created by Karina on 8/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
    
    @IBOutlet private weak var recipeStackView: UIStackView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentStyle()
    }
    
    private func updateContentStyle() {
        let isHorizontalStyle = bounds.width > 2 * bounds.height
        let oldAxis = recipeStackView.axis
        let newAxis: NSLayoutConstraint.Axis = isHorizontalStyle ? .horizontal : .vertical
        guard oldAxis != newAxis else { return }
        
        recipeStackView.axis = newAxis
        recipeStackView.spacing = isHorizontalStyle ? 10 : 0
        label.textAlignment = isHorizontalStyle ? .left : .center
//        let fontTransform: CGAffineTransform = isHorizontalStyle ? .identity : CGAffineTransform(scaleX: 0.8, y: 0.8)
        
//        UIView.animate(withDuration: 0.3) {
//            self.label.transform = fontTransform
//            self.layoutIfNeeded()
//        }
    }
    
}
