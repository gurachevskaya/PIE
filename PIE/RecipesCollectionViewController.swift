//
//  RecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/22/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class RecipesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let sectionInsets = UIEdgeInsets(top: 16.0, left: 8.0, bottom: 20.0, right: 8.0)
    private let itemsPerRow: CGFloat = 2
    private let minimumItemSpacing: CGFloat = 8
    
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
    
    private var selectedStyle: PresentationStyle = .table {
        didSet { updatePresentationStyle() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePresentationStyle()
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedStyle.buttonImage, style: .plain, target: self, action: #selector(changeContentLayout))
        
        // Register cell classes
        self.collectionView.register(RecipeCollectionViewCell.nib,
                                     forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.image = selectedStyle.buttonImage
    }
    
    @objc private func changeContentLayout() {
        if selectedStyle == .table {
            selectedStyle = .grid
        } else {
            selectedStyle = .table
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let itemSize = CGSize(width: widthPerItem, height: widthPerItem + 50)
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
