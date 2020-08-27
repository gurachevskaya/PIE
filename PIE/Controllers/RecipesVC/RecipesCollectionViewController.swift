//
//  RecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol LoadRecipesProtocol {
    func startLoading()
}

class RecipesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    func startLoading() {
        print("implement this method!")
    }
    
    
    var recipes: [Recipe] = []
    
    let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 10.0, right: 8.0)
    private let itemsPerRow: CGFloat = 2
    private let minimumItemSpacing: CGFloat = 8
    
    private enum PresentationStyle: String, CaseIterable {
        case table
        case grid
        var buttonImage: UIImage {
            switch self {
            case .table: return  UIImage(named:"table")!
            case .grid: return UIImage(named:"grid")!
            }
        }
    }
    
    private var selectedStyle: PresentationStyle = .grid {
        didSet { updatePresentationStyle() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePresentationStyle()
        
        RecipeEntity.deleteAllRecipes()
        
        startLoading()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
        
        self.collectionView.register(RecipeCollectionViewCell.nib,
                                     forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(SearchResultHeaderCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
    
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
        collectionView.reloadData()
    }
    
    @objc private func changeContentLayout() {
        if selectedStyle == .table {
            selectedStyle = .grid
        } else {
            selectedStyle = .table
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        let recipe = recipes[indexPath.item]
        cell.label.text = recipe.label
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = DetailedRecipeViewController(nibName: "DetailedRecipeViewController", bundle: nil)
        detailedVC.recipe = recipes[indexPath.item]
        navigationController?.pushViewController(detailedVC, animated: true)
    }

    
    
    
    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize : CGSize
        
        switch selectedStyle {
        case .table :
            let paddingSpace = sectionInsets.left + sectionInsets.right
            let widthPerItem = collectionView.bounds.width - paddingSpace
            
            itemSize = CGSize(width: widthPerItem, height: 150)
            
        case .grid :
            let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
            let availableWidth = collectionView.bounds.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            itemSize = CGSize(width: widthPerItem, height: widthPerItem + 50)
        }
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
