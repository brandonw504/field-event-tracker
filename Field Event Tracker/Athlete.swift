//
//  Athlete.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/14/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import Foundation

struct Athlete: Identifiable, Codable {
    var id: Int
    var name: String
    var school: String
    var results: [Mark]
    var resultsString: [String]
    
    var bestResultRanked: (Int, Double, Double?) {
        var bestResult = (0, 0.0)
        var bestWind: Double? = 0.0
        var bestFeet = 0
        var bestInches = 0.0
        
        for mark in results {
            if let currentFeet = mark.feet {
                if currentFeet >= bestFeet {
                    if let currentInches = mark.inches {
                        if currentInches > bestInches {
                            bestFeet = currentFeet
                            bestInches = currentInches
                            bestResult = (currentFeet, currentInches)
                            if let currentWind = mark.wind {
                                bestWind = currentWind
                            }
                        }
                    }
                }
            }
        }
        
        return bestFeet == 0 ? (-1, -1, -1) : (bestResult.0, bestResult.1, bestWind)
    }
    
    var bestResult: String {
        var bestResult = (0, 0.0)
        var bestWind: String? = ""
        var bestFeet = 0
        var bestInches = 0.0
        
        for mark in results {
            if let currentFeet = mark.feet {
                if currentFeet >= bestFeet {
                    if let currentInches = mark.inches {
                        if currentInches > bestInches {
                            bestFeet = currentFeet
                            bestInches = currentInches
                            bestResult = (currentFeet, currentInches)
                            if let currentWind = mark.wind {
                                bestWind = String(currentWind)
                            }
                        }
                    }
                }
            }
        }
        
        return bestFeet == 0 ? "Scratch" : "\(bestResult.0)' \(bestResult.1)\" (\(bestWind ?? "NWI"))"
    }
}
