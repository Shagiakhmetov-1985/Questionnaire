//
//  OptionsConfigurator.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import Foundation

protocol OptionsConfiguratorInputProtocol {
    func configure(with view: OptionsViewController, and questions: CountQuestions, and continent: Continent)
}

class OptionsConfigurator: OptionsConfiguratorInputProtocol {
    func configure(with view: OptionsViewController, and questions: CountQuestions, and continent: Continent) {
        let presenter = OptionsPresenter(view: view)
        let interactor = OptionsInteractor(presenter: presenter, questions: questions, continent: continent)
        let router = OptionsRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
