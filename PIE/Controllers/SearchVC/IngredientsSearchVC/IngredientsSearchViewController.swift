//
//  IngredientsSearchViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class IngredientsSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var textFields: [UITextField] {
        return [firstTextField, secondTextField, thirdTextField]
    }
    
    let searchPresenter: SearchPresenter
    let cellIdentifier = "FilterCollectionViewCell"
    
    init(searchPresenter: SearchPresenter) {
        self.searchPresenter = searchPresenter
        super.init(nibName: "IngredientsSearchViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPresenter.view = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        self.collectionView.register(FilterCollectionViewCell.nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPresenter.numberOfFilters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FilterCollectionViewCell
        
        let filter = searchPresenter[indexPath.item]
        cell.filterLabel.text = filter.name
        cell.switch.isOn = filter.isSelected
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchPresenter.toggleSelectedFor(item: indexPath.item)
    }
    
    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - 30
        let widthPerItem = availableWidth / 2
        let itemSize = CGSize(width: widthPerItem, height: 80)
        return itemSize
    }
    
    
    //MARK: - Handlers
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func findRecipesButtonPressed(_ sender: Any) {
        
        var ingredients: [String] = []
        
        for field in textFields {
            if field.text?.isEmpty == false {
                ingredients.append(field.text!)
            }
        }
        
        let searchQuery = ingredients.joined(separator: "+")
        
        searchPresenter.getRecipes(ingredients: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                if case .noSearchParameters = (appError as AppError) {
                    self?.showAlertWithMessage(message: "Enter at least 1 ingredient")
                } else if case .noRecipes = (appError as AppError) {
                    self?.showAlertWithMessage(message: "We haven't found recipes with your search parameters 😢")
                } else {
                    self?.showAlertWithMessage(message: "\(appError)")
                }
                
            case .success(let (recipes, more)):
                DispatchQueue.main.async {
                    let vc = RecipesViewControllerFactory().makeAllRecipesViewController()
                    vc.recipesPresenter.recipes = recipes
                    vc.recipesPresenter.more = more
                    vc.recipesPresenter.searchQuery = searchQuery
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension IngredientsSearchViewController: SimpleSearchView {
    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

extension IngredientsSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
