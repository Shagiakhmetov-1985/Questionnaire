//
//  StorageManager.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 18.04.2023.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let questionsKey = "countQuestions"
    private let continentsKey = "continents"
    
    private init() {}
    
    func saveQuestions(_ countQuestions: CountQuestions) {
        userDefaults.set(countQuestions.rawValue, forKey: questionsKey)
    }
    
    func saveContinents(_ continents: Continent) {
        userDefaults.set(continents.rawValue, forKey: continentsKey)
    }
    
    func fetchOptions() -> (CountQuestions, Continent) {
        guard let questions = userDefaults.object(forKey: questionsKey) as? Int else { return (CountQuestions.fiveQuestions, Continent.allCountries) }
        let getQuestions = CountQuestions(rawValue: questions) ?? CountQuestions.fiveQuestions
        guard let continents = userDefaults.object(forKey: continentsKey) as? String else { return (CountQuestions.fiveQuestions, Continent.allCountries) }
        let getContinents = Continent(rawValue: continents) ?? Continent.allCountries
        return (getQuestions, getContinents)
    }
}
