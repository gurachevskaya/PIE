//
//  DetailedRecipeViewController.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit


class DetailedRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dietsLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
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
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateElements()
        
        if detailedPresenter.isInFavourites {
            saveButton.setImage(UIImage(named: "bookmark-filled"), for: UIControl.State.normal)
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    //MARK: - UI Setup
    
    private func updateElements() {
        recipeLabel.text = detailedPresenter.label
        caloriesLabel.text = detailedPresenter.calories
        servingsLabel.text = detailedPresenter.servings
        sourceLabel.text = detailedPresenter.source
        ingredients.text = detailedPresenter.ingredients
        dietsLabel.text = detailedPresenter.dietsAndHealth
        
        recipePresenter.loadImageForUrl(urlString: detailedPresenter.recipe.image) { [weak self] (result) in
            guard let self = self else { return }
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
    
    //MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if !detailedPresenter.isInFavourites {
            saveButton.setImage(UIImage(named: "bookmark-filled"), for: UIControl.State.normal)
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
             navigationItem.rightBarButtonItem = deleteButton
            showAlertWithTimer()
            detailedPresenter.addInFavourites()
        }
    }
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let url = URL(string: detailedPresenter.recipe.url) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func instructionsButtonPressed(_ sender: Any) {
        detailedPresenter.openUrl()
    }
    
    
    @objc func deleteButtonPressed() {
        showDeleteAlert()
        
    }
            
    //MARK: - Helpers
    
    private func showAlertWithTimer() {
        alertController = UIAlertController(title: title, message: "Successfully saved", preferredStyle: .alert)
        alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        present(alertController!, animated: true, completion: nil)
    }
    
    
    @objc func countDown() {
        remainingTime -= 1
        if (remainingTime < 0) {
            alertTimer?.invalidate()
            alertTimer = nil
            alertController!.dismiss(animated: true, completion: { [weak self] in
                self?.alertController = nil
            })
        }
    }
    
    func showDeleteAlert() {
        let alertVC = UIAlertController(title: nil, message: "Are you sure to delete recipe?", preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Yes", style: .default,
                                        handler: {(_) in
                                            self.detailedPresenter.deleteFromFavourites()
                                            self.navigationController?.popViewController(animated: true)
        }))
        alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
   
}

