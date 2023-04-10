//
//  FlagsManager.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import Foundation

struct FlagsManager {
    let flag: String
    let name: String
}

extension FlagsManager {
    static func getFlags() -> [FlagsManager] {
        var countries: [FlagsManager] = []
        
        let flags = Flags.shared.images
        let names = Flags.shared.names
        let iterationCount = min(flags.count, names.count)
        
        for index in 0..<iterationCount {
            let information = FlagsManager(
                flag: flags[index],
                name: names[index]
            )
            countries.append(information)
        }
        
        return countries
    }
}
