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
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var ingredients: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ratio: CGFloat
        if let image = recipeImage.image {
            ratio = image.size.height / image.size.width
        } else {
            ratio = 1
        }
        recipeImage.heightAnchor .constraint(equalTo: recipeImage.widthAnchor, multiplier: ratio).isActive = true
        
        ingredients.text = "first one\nsecond one\nthird one"
        
        cosmosView.settings.updateOnTouch = false
        cosmosView.rating = 6.0
    }
    


//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 10
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseID")
//            if (cell == nil) {
//                cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier:"reuseID")
//            }
//            cell!.textLabel!.text = "\(indexPath.row)"
//            return cell!
//
//        }

}
