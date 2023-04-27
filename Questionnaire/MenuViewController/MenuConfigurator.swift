//
//  MenuConfigurator.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 25.04.2023.
//

import Foundation

protocol MenuConfiguratorInputProtocol {
//    func configure(with view: MenuViewController, and questions: CountQuestions, and continent: Continent)
    func configure(with view: MenuViewController)
}

class MenuConfigurator: MenuConfiguratorInputProtocol {
//    func configure(with view: MenuViewController, and questions: CountQuestions, and continent: Continent) {
//        let presenter = MenuPresenter(view: view)
//        let interactor = MenuInteractor(presenter: presenter, questions: questions, continent: continent)
//
//        view.presenter = presenter
//        presenter.interactor = interactor
//    }
    
    func configure(with view: MenuViewController) {
        let presenter = MenuPresenter(view: view)
        let interactor = MenuInteractor(presenter: presenter)
        let router = MenuRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
