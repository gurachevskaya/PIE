//
//  IngredientsSearchBuilder.swift
//  PIE
//
//  Created by Karina on 9/13/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class IngredientsSearchBuilder: ModuleBuilder {
    func build() -> UIViewController {
        let presenter = SearchPresenter(model: filtersModel)
        let controller = IngredientsSearchViewController(searchPresenter: presenter)
        presenter.view = controller
        return controller
    }
}
