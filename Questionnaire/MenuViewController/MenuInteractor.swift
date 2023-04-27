//
//  MenuInteractor.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 25.04.2023.
//

import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    init(presenter: MenuInteractorOutputProtocol)
    func fetchData()
    func sendData(questions: CountQuestions, continent: Continent)
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func receiveMode(questions: CountQuestions, continents: Continent)
    func sendData(questions: CountQuestions, continents: Continent)
}

class MenuInteractor: MenuInteractorInputProtocol {
    unowned let presenter: MenuInteractorOutputProtocol
    
    required init(presenter: MenuInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchData() {
        let countQuestions = StorageManager.shared.fetchOptions().0
        let continent = StorageManager.shared.fetchOptions().1
        presenter.receiveMode(questions: countQuestions, continents: continent)
    }
    
    func sendData(questions: CountQuestions, continent: Continent) {
        presenter.sendData(questions: questions, continents: continent)
    }
    
    /*
    private func getRandomQuestions() -> [FlagsManager] {
        switch continent {
        case .allCountries: return FlagsManager.getAllCountries().shuffled()
        case .americaContinent: return FlagsManager.getAmericanContinent().shuffled()
        case .europeContinent: return FlagsManager.getEuropeanContinent().shuffled()
        case .africaContinent: return FlagsManager.getAfricanContinent().shuffled()
        case .asiaContinent: return FlagsManager.getAsianContinent().shuffled()
        default: return FlagsManager.getOceanContinent().shuffled()
        }
    }
    
    private func countQuestions(_ questions: [FlagsManager]) -> [FlagsManager] {
        var count: [FlagsManager] = []
        let numbers = countQuestions.rawValue
        
        for index in 0..<numbers {
            count.append(questions[index])
        }
        
        return count
    }
    
    private func getChoosingAnswers(_ countQuestions: [FlagsManager], _ allQuestions: [FlagsManager]) -> [FlagsManager] {
        var choosingAnswers: [FlagsManager] = []
        
        for index in 0..<countQuestions.count {
            var fourAnswers: [FlagsManager] = []
            var answers = allQuestions
            fourAnswers.append(answers[index])
            answers.remove(at: index)
            
            let threeAnswers = wrongAnswers(answers)
            fourAnswers += threeAnswers
            fourAnswers.shuffle()
            choosingAnswers += fourAnswers
        }
        
        return choosingAnswers
    }
    
    private func wrongAnswers(_ answers: [FlagsManager]) -> [FlagsManager] {
        var threeAnswers: [FlagsManager] = []
        var wrongAnswers = answers
        var counter = 0
        
        while(counter < 3) {
            let index = Int.random(in: 0..<wrongAnswers.count)
            let wrongAnswer = wrongAnswers[index]
            threeAnswers.append(wrongAnswer)
            wrongAnswers.remove(at: index)
            counter += 1
        }
        
        return threeAnswers
    }
    
    private func getAnswers(_ answers: [FlagsManager]) -> (answerFirst: [FlagsManager],
                                                           answerSecond: [FlagsManager],
                                                           answerThird: [FlagsManager],
                                                           answerFourth: [FlagsManager]) {
        let countQuestions = countQuestions.rawValue
        var first: [FlagsManager] = []
        var second: [FlagsManager] = []
        var third: [FlagsManager] = []
        var fourth: [FlagsManager] = []
        var counter = 0
        
        while(counter < countQuestions * 4) {
            first.append(answers[counter])
            second.append(answers[counter + 1])
            third.append(answers[counter + 2])
            fourth.append(answers[counter + 3])
            counter += 4
        }
        
        return (first, second, third, fourth)
    }
    
    private func getQuestions() -> (questions: [FlagsManager],
                                    answerFirst: [FlagsManager],
                                    answerSecond: [FlagsManager],
                                    answerThird: [FlagsManager],
                                    answerFourth: [FlagsManager]) {
        let randomQuestions = getRandomQuestions()
        
        let countQuestions = countQuestions(randomQuestions)
        
        let choosingAnswers = getChoosingAnswers(countQuestions, randomQuestions)
        
        let answers = getAnswers(choosingAnswers)
        
        return (countQuestions, answers.answerFirst, answers.answerSecond, answers.answerThird, answers.answerFourth)
    }
     */
}
