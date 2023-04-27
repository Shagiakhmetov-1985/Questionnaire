//
//  OptionsInteractor.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import Foundation

protocol OptionsInteractorInputProtocol: AnyObject {
    init(presenter: OptionsInteractorOutputProtocol, questions: CountQuestions, continent: Continent)
    func provideQuestions()
}

protocol OptionsInteractorOutputProtocol: AnyObject {
    func receiveMode(questions: CountQuestions, continents: Continent)
}

class OptionsInteractor: OptionsInteractorInputProtocol {
    unowned let presenter: OptionsInteractorOutputProtocol
    let countQuestions: CountQuestions
    let continent: Continent
    
    required init(presenter: OptionsInteractorOutputProtocol, questions: CountQuestions, continent: Continent) {
        self.presenter = presenter
        self.countQuestions = questions
        self.continent = continent
    }
    
    func provideQuestions() {
        presenter.receiveMode(questions: countQuestions, continents: continent)
    }
}
