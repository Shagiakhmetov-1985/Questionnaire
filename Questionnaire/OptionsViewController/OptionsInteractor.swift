//
//  OptionsInteractor.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import Foundation

protocol OptionsInteractorInputProtocol: AnyObject {
    init(presenter: OptionsInteractorOutputProtocol, questions: CountQuestions, continent: Continent)
    func backToMenu(questions: CountQuestions, continent: Continent)
}

protocol OptionsInteractorOutputProtocol: AnyObject {
    func sendDataToMenu(questions: CountQuestions, continent: Continent)
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
    
    func backToMenu(questions: CountQuestions, continent: Continent) {
        presenter.sendDataToMenu(questions: questions, continent: continent)
    }
}
