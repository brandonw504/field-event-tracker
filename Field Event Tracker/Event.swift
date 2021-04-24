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
        // var athletesRanked = [Athlete]()
        // var nextGreatest = (0, 0.0)
        var localAthletes = athletes
        
        localAthletes.sort { (current: Athlete, next: Athlete) -> Bool in
            if Double(current.bestResultRanked.0 * 12) + current.bestResultRanked.1 > Double(next.bestResultRanked.0 * 12) + current.bestResultRanked.1 {
                return true
            }
            return false
        }
        return localAthletes
        /*
        for athlete in athletes {
            for comparison in athletes {
                if Double(comparison.bestResultRanked.0 * 12) + comparison.bestResultRanked.1 > Double(athlete.bestResultRanked.0 * 12) + athlete.bestResultRanked.1 {
                    if Double(comparison.bestResultRanked.0 * 12) + comparison.bestResultRanked.1 < Double(nextGreatest.0 * 12) + nextGreatest.1 {
                        nextGreatest = (comparison.bestResultRanked.0, comparison.bestResultRanked.1)
                    }
                }
            }
        }
        */
    }
}
