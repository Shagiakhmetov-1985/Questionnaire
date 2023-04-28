//
//  OptionsPresenter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import Foundation

class OptionsPresenter: OptionsViewOutputProtocol {
    unowned let view: OptionsViewInputProtocol
    var interactor: OptionsInteractorInputProtocol!
    var router: OptionsRouterInputProtocol!
    
    required init(view: OptionsViewInputProtocol) {
        self.view = view
    }
    
    func backToMenu(questions: CountQuestions, continent: Continent) {
        interactor.backToMenu(questions: questions, continent: continent)
    }
}

extension OptionsPresenter: OptionsInteractorOutputProtocol {
    func sendDataToMenu(questions: CountQuestions, continent: Continent) {
        router.closeOptionsViewController(with: questions, and: continent)
    }
}
