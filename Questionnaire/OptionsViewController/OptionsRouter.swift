//
//  OptionsRouter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 28.04.2023.
//

import Foundation

protocol OptionsRouterInputProtocol {
    init(viewController: OptionsViewController)
    func closeOptionsViewController(with questions: CountQuestions, and continent: Continent)
}

class OptionsRouter: OptionsRouterInputProtocol {
    unowned let viewController: OptionsViewController
    
    required init(viewController: OptionsViewController) {
        self.viewController = viewController
    }
    
    func closeOptionsViewController(with questions: CountQuestions, and continent: Continent) {
        let menuVC: MenuViewInputProtocol = MenuViewController()
        menuVC.getMode(questions: questions, continents: continent)
        viewController.dismiss(animated: true)
    }
}
