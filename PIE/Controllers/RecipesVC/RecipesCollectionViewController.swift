//
//  RecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit


class RecipesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout/*, RecipeLoading*/ {
    
    private let reuseIdentifier = "RecipeCollectionViewCell"
    var recipesPresenter: RecipesPresenter
    
    init(recipesPresenter: RecipesPresenter) {
        self.recipesPresenter = recipesPresenter
        super.init(nibName: "RecipesCollectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePresentationStyle()
        recipesPresenter.view = self
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: selectedStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))]
        
        self.collectionView.register(RecipeCollectionViewCell.nib,
                                     forCellWithReuseIdentifier: reuseIdentifier)
    }
    
     //MARK: - UI Setup
    
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
        reloadData()
    }
    
    
    @objc private func changeContentLayout() {
        if selectedStyle == .table {
            selectedStyle = .grid
        } else {
            selectedStyle = .table
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesPresenter.numberOfRecipes
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        let recipe = recipesPresenter.recipes[indexPath.item]
        cell.label.text = recipe.label
        
        cell.recipeImageView.image = UIImage(named: "lazy-load-placeholder")
        
        recipesPresenter.loadImageForUrl(urlString: recipe.image) { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlertWithMessage(message: "\(appError)")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    cell.recipeImageView.image = image
                }
            }
        }
          return cell
    }
    
    // MARK: - UICollectionViewDelegate
       
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let detailedVC = DetailedRecipeViewController(recipePresenter: RecipesPresenter(), detailedPresenter: DetailedRecipePresenter(recipe: recipesPresenter.recipes[indexPath.item]))
           DispatchQueue.main.async {
               self.navigationController?.pushViewController(detailedVC, animated: true)
           }
       }
    
     // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if recipesPresenter.more {
                recipesPresenter.getMoreRecipes {(result) in
                    switch result {
                    case .failure(let appError):
                        if case .noRecipes = (appError as AppError) {
                            self.showAlertWithMessage(message: "You have seen all recipes with this search parameters\n p.s.this API plan allows only 100 recipes in one search")
                        } else if case .tooManyRequests = (appError as AppError) {
                             self.showAlertWithMessage(message: "Your API plan allows 5 requests/min. Wait a little")
                        } else {
                            self.showAlertWithMessage(message: "\(appError)")
                        }

                    case .success(let recipes):
                        DispatchQueue.main.async {
                            self.recipesPresenter.recipes.append(contentsOf: recipes)
                            self.reloadData()
                        }
                    }
                }
            } else {
                showAlertWithMessage(message: "That's all recipes with this search parameters we have found for you")
            }
        }
    }
 
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize : CGSize
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let minimumItemSpacing = layout.minimumInteritemSpacing
        let sectionInsets = layout.sectionInset
        let itemsPerRow: CGFloat = 2
        
        switch selectedStyle {
        case .table :
            let paddingSpace = sectionInsets.left + sectionInsets.right
            let widthPerItem = collectionView.bounds.width - paddingSpace
            itemSize = CGSize(width: widthPerItem, height: 150)
            
        case .grid :
            let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
            let availableWidth = collectionView.bounds.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            
            //            let recipe = recipesPresenter.recipes[indexPath.item]
            //            let size = CGSize(width: widthPerItem, height: widthPerItem)
            
            //            let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!]
            //            let estimatedFrame = NSString(string: recipe.label).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            //            let heightPerItem = widthPerItem + estimatedFrame.height
            let paddingSpace2 = sectionInsets.top + sectionInsets.bottom + minimumItemSpacing
            let tabBarHeight = tabBarController?.tabBar.frame.height ?? 49.0
            let nbHeight = navigationController?.navigationBar.frame.height ?? 44.0
            let availableHeight = collectionView.bounds.height - paddingSpace2 - tabBarHeight - nbHeight
            let heightPerItem = availableHeight / 2
            
            itemSize = CGSize(width: widthPerItem, height: heightPerItem - 10)
        }
        return itemSize
    }
}
    

extension RecipesCollectionViewController: RecipeView {
    func reloadData() {
        collectionView.reloadData()
    }
}

