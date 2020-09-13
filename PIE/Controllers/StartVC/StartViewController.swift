//
//  StartViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "SearchTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell
        
        if indexPath.section == 0 {
            cell.configureWith(type: .simpleSearch)
        }
        
        if indexPath.section == 1 {
            cell.configureWith(type: .ingredientsSearch)
        } 
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            navigationController?.pushViewController(SimpleSearchBuilder().build(), animated: true)
        }
        
        if indexPath.section == 1 {
            navigationController?.pushViewController(IngredientsSearchBuilder().build(), animated: true)
        }
    }
}
