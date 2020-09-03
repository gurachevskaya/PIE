//
//  DetailedRecipeViewController.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints


class DetailedRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    private var alertController: UIAlertController?
    private var alertTimer: Timer?
    private var remainingTime = 1
    
    var recipePresenter: RecipesPresenter
    var detailedPresenter: DetailedRecipePresenter
    
    init(recipePresenter: RecipesPresenter, detailedPresenter: DetailedRecipePresenter) {
        self.recipePresenter = recipePresenter
        self.detailedPresenter = detailedPresenter
        super.init(nibName: "DetailedRecipeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        detailedPresenter.view = self
        
        configureWithRecipe()
        configureImageConstraints()
        
        if detailedPresenter.isInFavourites {
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
                   navigationItem.rightBarButtonItem = deleteButton
            cosmosView.isHidden = false
        }
    }
    
    //MARK: - UI Setup
    
    private func configureWithRecipe() {
        recipeLabel.text = detailedPresenter.label
        caloriesLabel.text = detailedPresenter.calories
        servingsLabel.text = detailedPresenter.servings
        sourceLabel.text = detailedPresenter.source
        ingredients.text = detailedPresenter.ingredients
        
        recipePresenter.loadImageForUrl(urlString: detailedPresenter.recipe.image) { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlertWithMessage(message: "\(appError)")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.recipeImage.image = image
                }
            }
        }
        
    }
    
    private func configureImageConstraints() {
//        let ratio: CGFloat
//        if let image = recipeImage.image {
//            ratio = image.size.height / image.size.width
//        } else {
//            ratio = 1
//        }
//        recipeImage.heightAnchor .constraint(equalTo: recipeImage.widthAnchor, multiplier: ratio).isActive = true
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        showAlertWithTimer()
        detailedPresenter.addInFavourites()
//        recipePresenter.recipes.append(recipe)
//        recipePresenter.view?.reloadData()
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let url = URL(string: detailedPresenter.recipe.url) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func instructionsButtonPressed(_ sender: Any) {
        detailedPresenter.openUrl()
    }
    
    
    @objc func deleteButtonPressed() {
        detailedPresenter.deleteFromFavourites()
    }
    
    //MARK: - Helpers
    
    private func showAlertWithTimer() {
        alertController = UIAlertController(title: title, message: detailedPresenter.saveMessage, preferredStyle: .alert)
        alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    @objc func countDown() {
        remainingTime -= 1
        if (remainingTime < 0) {
            alertTimer?.invalidate()
            alertTimer = nil
            alertController!.dismiss(animated: true, completion: {
                self.alertController = nil
            })
        }
    }
    
    
}

