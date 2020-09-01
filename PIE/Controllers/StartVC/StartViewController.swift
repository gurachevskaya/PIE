//
//  StartViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! SearchTableViewCell
        
        if indexPath.section == 0 {
            cell.searchTextLabel.text = "Simple search by name"
            cell.searchImageView.image = UIImage(named: "dish")
        }
        
        if indexPath.section == 1 {
            cell.searchTextLabel.text = "Find recipes based on what you already have at home!"
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            navigationController?.pushViewController(SimpleSearchViewController(searchPresenter: SearchPresenter()), animated: true)
        }
        
        if indexPath.section == 1 {
             navigationController?.pushViewController(IngredientsSearchViewController(searchPresenter: SearchPresenter()), animated: true)
        }
    }
}
