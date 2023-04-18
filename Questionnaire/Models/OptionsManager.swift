//
//  OptionsManager.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 18.04.2023.
//

import Foundation

struct OptionsManager: Codable {
    var countQuestions: CountQuestions.RawValue
    var continents: Continent.RawValue
}
