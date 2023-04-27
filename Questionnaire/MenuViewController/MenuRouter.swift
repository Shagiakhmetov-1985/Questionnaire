//
//  MenuRouter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import UIKit

protocol MenuRouterInputProtocol {
    init(viewController: MenuViewController)
    func openOptionsViewController(with questions: CountQuestions, and continent: Continent)
}

class MenuRouter: MenuRouterInputProtocol {
    unowned let viewController: MenuViewController
    
    required init(viewController: MenuViewController) {
        self.viewController = viewController
    }
    
    func openOptionsViewController(with questions: CountQuestions, and continent: Continent) {
        let optionsVC = OptionsViewController()
        optionsVC.setOptions(questions: questions, continents: continent)
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        viewController.present(navigationVC, animated: true)
    }
}
