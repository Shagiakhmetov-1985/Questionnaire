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
    private let optionsKey = "options"
    
    private init() {}
    
    func rewriteSetting(optionsManager: OptionsManager) {
        guard let data = try? JSONEncoder().encode(optionsManager) else { return }
        userDefaults.set(data, forKey: optionsKey)
    }
    
    func fetchOptions() -> OptionsManager {
        guard let data = userDefaults.object(forKey: optionsKey) as? Data else { return OptionsManager(countQuestions: CountQuestions.fiveQuestions.rawValue, continents: Continent.allCountries.rawValue) }
        guard let setting = try? JSONDecoder().decode(OptionsManager.self, from: data) else { return OptionsManager(countQuestions: CountQuestions.fiveQuestions.rawValue, continents: Continent.allCountries.rawValue) }
        return setting
    }
}
