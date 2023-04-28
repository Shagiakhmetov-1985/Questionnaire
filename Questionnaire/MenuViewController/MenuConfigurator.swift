//
//  MenuConfigurator.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 25.04.2023.
//

import Foundation

protocol MenuConfiguratorInputProtocol {
    func configure(with view: MenuViewController)
}

class MenuConfigurator: MenuConfiguratorInputProtocol {
    func configure(with view: MenuViewController) {
        let presenter = MenuPresenter(view: view)
        let interactor = MenuInteractor(presenter: presenter)
        let router = MenuRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
