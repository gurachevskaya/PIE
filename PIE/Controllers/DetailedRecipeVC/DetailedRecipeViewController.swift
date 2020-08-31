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
    
    var recipe: Recipe!
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
    
    //MARK: - App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWithRecipe()
        
        let ratio: CGFloat
        if let image = recipeImage.image {
            ratio = image.size.height / image.size.width
        } else {
            ratio = 1
        }
        recipeImage.heightAnchor .constraint(equalTo: recipeImage.widthAnchor, multiplier: ratio).isActive = true
        
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
        
        navigationItem.rightBarButtonItem = deleteButton
                
        cosmosView.settings.updateOnTouch = false
        cosmosView.rating = 6.0
    }
    
    //MARK: - UI Setup
    
    private func configureWithRecipe() {
        
        recipeLabel.text = recipe.label
        caloriesLabel.text = "\(Int(recipe.calories))"
        servingsLabel.text = "\(recipe.yield)"
        sourceLabel.text = "on " + recipe.source
        var ingredientsText = ""
        for row in recipe.ingredientLines {
            ingredientsText += "🥣 " + row + "\n"
        }
        ingredients.text = ingredientsText
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let message: String
        if RecipeEntity.isAlreadyInFavourite(recipe: self.recipe) {
            message = "Already saved"
        } else {
            RecipeEntity.addRecipe(recipe: recipe)
            message = "Successfully saved"
        }
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let url = URL(string: recipe.url) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [])
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func instructionsButtonPressed(_ sender: Any) {
        guard let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @objc func deleteButtonPressed() {
        RecipeEntity.deleteRecipe(recipe: recipe)
    }
    
    //MARK: - Helpers
    
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
