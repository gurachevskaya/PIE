//
//  SimpleSearchViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class SimpleSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let cellIdentifier = "cellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(FilterCollectionViewCell.nib, forCellWithReuseIdentifier: cellIdentifier)
 

    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtersModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FilterCollectionViewCell
        let filter = filtersModel[indexPath.item]
        cell.filterLabel.text = filter.name
        cell.switch.isOn = filter.isSelected
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filtersModel[indexPath.item].toggleSelected()
        collectionView.reloadData()
       }
   
    
    // MARK: UICollectionViewFlowLayout
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
//        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - 30
        let widthPerItem = availableWidth / 2
        let itemSize = CGSize(width: widthPerItem, height: 80)
        return itemSize
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
     
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//         return sectionInsets
//     }
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//         return minimumItemSpacing
//     }
    
    
    // MARK: Actions
    
    @IBAction func findRecipesButtonPressed(_ sender: Any) {
        
        RecipeAPI.fetchRecipe(for: "all") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError.localizedDescription)")
            // TODO: alert controller
            case .success(let recipes):
            //self?.recipes = recipes
            let vc = RecipesViewControllerFactory().makeAllRecipesViewController()
            vc.recipes = recipes
            
//            RecipeEntity.addRecipe(recipe: recipes[0])
//            RecipeEntity.addRecipe(recipe: recipes[1])

            
            DispatchQueue.main.async {
               self?.navigationController?.pushViewController(vc, animated: true)
            }
            }
        }
    }
}





