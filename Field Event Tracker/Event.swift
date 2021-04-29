//
//  Event.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/16/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import Foundation

struct Event: Identifiable, Codable {
    var id: Int
    var name: String
    var gender: String
    var division: String
    var athletes: [Athlete]
    
    var athletesRanked: [Athlete] {
        var localAthletes = athletes
        
        localAthletes.sort { (current: Athlete, next: Athlete) -> Bool in
            return Double(current.bestResultRanked.0 * 12) + current.bestResultRanked.1 > Double(next.bestResultRanked.0 * 12) + current.bestResultRanked.1
        }
        return localAthletes
    }
}
