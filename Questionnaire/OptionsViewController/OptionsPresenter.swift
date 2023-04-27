//
//  OptionsPresenter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 27.04.2023.
//

import Foundation

struct OptionsData {
    let countQuestions: CountQuestions
    let continent: Continent
}

class OptionsPresenter: OptionsViewOutputProtocol {
    unowned let view: OptionsViewInputProtocol
    var interactor: OptionsInteractorInputProtocol!
    
    required init(view: OptionsViewInputProtocol) {
        self.view = view
    }
}

extension OptionsPresenter: OptionsInteractorOutputProtocol {
    func receiveMode(questions: CountQuestions, continents: Continent) {
        view.getMode(questions: questions, continents: continents)
    }
}
