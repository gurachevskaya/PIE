//
//  SimpleSearchViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit


protocol SimpleSearchView: class {
    func reloadData()
    func invalidateLayout()
    
    func startLoading()
    func finishLoading()

//    func showUserRepository(with user: User)
//    func updateTotalCountLabel(_ countText: String)
//    func updateLoadingView(with view: UIView, isLoading: Bool)
//    func showEmptyTokenError(errorMessage: ErrorMessage)
}


class SimpleSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "cellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    @IBOutlet weak var findRecipesButtonBottomConstraint: NSLayoutConstraint!
    //    @IBOutlet private(set) weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //+activityIndicatorView??????
    
     let simpleSearchPresenter: SearchPresenter
    
    init(searchPresenter: SearchPresenter) {
           self.simpleSearchPresenter = searchPresenter
           super.init(nibName: "SimpleSearchViewController", bundle: nil)
       }
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(FilterCollectionViewCell.nib, forCellWithReuseIdentifier: cellIdentifier)
                
         simpleSearchPresenter.view = self
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simpleSearchPresenter.numberOfFilters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FilterCollectionViewCell
        
        let filter = simpleSearchPresenter[indexPath.item]
        cell.filterLabel.text = filter.name
        cell.switch.isOn = filter.isSelected
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        simpleSearchPresenter.toggleSelectedFor(item: indexPath.item)
        reloadData()
       }
   
    
    // MARK: - UICollectionViewDelegateFlowLayout
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 30
        let widthPerItem = availableWidth / 2
        let itemSize = CGSize(width: widthPerItem, height: 80)
        return itemSize
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        invalidateLayout()
    }
    
    // MARK: - Actions
    
    @IBAction func findRecipesButtonPressed(_ sender: Any) {
        
        let searchQuery = recipeSearchBar.text ?? ""
        
        simpleSearchPresenter.getRecipes(for: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                if case .noSearchParameters = (appError as AppError) {
                self?.showAlertWithMessage(message: "Enter recipe name or choose at least 1 filter")
                } else if case .noRecipes = (appError as AppError) {
                self?.showAlertWithMessage(message: "We haven't found recipes with your search parameters 😢")
                } else {
                    self?.showAlertWithMessage(message: "\(appError)")
                }

            case .success(let recipes):
                 DispatchQueue.main.async {
                let vc = RecipesViewControllerFactory().makeAllRecipesViewController()
                vc.recipesPresenter.recipes = recipes
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension SimpleSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}


extension SimpleSearchViewController: SimpleSearchView {
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
    
    func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
   
    
    //    func keyboardWillShow(with keyboardInfo: UIKeyboardInfo) {
    ////        view.layoutIfNeeded()
    ////        let extra = tabBarController?.tabBar.bounds.height ?? 0
    ////        tableViewBottomConstraint.constant = keyboardInfo.frame.size.height - extra
    ////        UIView.animate(withDuration: keyboardInfo.animationDuration,
    ////                       delay: 0,
    ////                       options: keyboardInfo.animationCurve,
    ////                       animations: { self.view.layoutIfNeeded() },
    ////                       completion: nil)
    //    }
    
    //    func keyboardWillHide(with keyboardInfo: UIKeyboardInfo) {
    ////        view.layoutIfNeeded()
    ////        tableViewBottomConstraint.constant = 0
    ////        UIView.animate(withDuration: keyboardInfo.animationDuration,
    ////                       delay: 0,
    ////                       options: keyboardInfo.animationCurve,
    ////                       animations: { self.view.layoutIfNeeded() },
    ////                       completion: nil)
    //    }
    
    
    
}



