//
//  FlagsManager.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import Foundation

struct FlagsManager: Equatable {
    let flag: String
    let name: String
    var select: Bool
}

extension FlagsManager {
    static func getAllCountries() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.images
        let names = Flags.shared.names
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
    
    static func getAmericanContinent() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.imagesOfAmericanContinent
        let names = Flags.shared.countriesOfAmericanContinent
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
    
    static func getEuropeanContinent() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.imagesOfEuropeanContinent
        let names = Flags.shared.countriesOfEuropeanContinent
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
    
    static func getAfricanContinent() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.imagesOfAfricanContinent
        let names = Flags.shared.countriesOfAfricanContinent
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
    
    static func getAsianContinent() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.imagesOfAsianContinent
        let names = Flags.shared.countriesOfAsianContinent
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
    
    static func getOceanContinent() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.imagesOfOceanContinent
        let names = Flags.shared.countriesOfOceanContinent
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index],
                select: false
            )
            countries.append(information)
        }
        
        return countries
    }
}

enum CountQuestions: Int, CaseIterable {
    case fiveQuestions = 5
    case tenQuestions = 10
    case fifteenQuestions = 15
    case twentyQuestions = 20
}

enum Continent: String, CaseIterable {
    case allCountries = "Все страны"
    case americaContinent = "Континент Америки"
    case europeContinent = "Континент Европы"
    case africaContinent = "Континент Африки"
    case asiaCOntinent = "Континент Азии"
    case oceaniaContinent = "Континент Океании"
}

enum Options: String, CaseIterable {
    case numberQuestions = "Количество вопросов"
    case contentsOfWorld = "Текущий континент"
}
