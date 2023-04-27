//
//  MenuPresenter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 25.04.2023.
//

import Foundation

class MenuPresenter: MenuViewOutputProtocol {
    unowned let view: MenuViewInputProtocol
    var interactor: MenuInteractorInputProtocol!
    var router: MenuRouterInputProtocol!
    
    required init(view: MenuViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didTapOptions(questions: CountQuestions, continent: Continent) {
        interactor.sendData(questions: questions, continent: continent)
    }
}
// MARK: - MenuInteractorOutputProtocol
extension MenuPresenter: MenuInteractorOutputProtocol {
    func receiveMode(questions: CountQuestions, continents: Continent) {
        view.getMode(questions: questions, continents: continents)
    }
    
    func sendData(questions: CountQuestions, continents: Continent) {
        router.openOptionsViewController(with: questions, and: continents)
    }
}
