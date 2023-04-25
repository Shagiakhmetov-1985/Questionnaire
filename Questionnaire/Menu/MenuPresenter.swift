//
//  MenuPresenter.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 25.04.2023.
//

import Foundation

struct MenuData {
    let receiveQuestions: (questions: [FlagsManager],
                           answerFirst: [FlagsManager],
                           answerSecond: [FlagsManager],
                           answerThird: [FlagsManager],
                           answerFourth: [FlagsManager])
}

class MenuPresenter: MenuViewOutputProtocol {
    unowned let view: MenuViewInputProtocol
    var interactor: MenuInteractorInputProtocol!
    
    required init(view: MenuViewInputProtocol) {
        self.view = view
    }
    
    func getQuestions() {
        interactor.provideData()
    }
}
// MARK: - MenuInteractorOutputProtocol
extension MenuPresenter: MenuInteractorOutputProtocol {
    func receiveData(with data: MenuData) {
        view.getQuestions(questions: data.receiveQuestions)
    }
}
