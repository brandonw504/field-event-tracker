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
        var allScratched = true
        
        if results.count == 0 {
            return (-1, -1, -1)
        }
        
        while allScratched {
            for mark in results {
                if mark.feet != nil {
                    allScratched = false
                }
            }
        }
        
        for mark in results {
            if let currentFeet = mark.feet {
                if currentFeet >= bestFeet {
                    if let currentInches = mark.inches {
                        if currentInches > bestInches || currentFeet > bestFeet {
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
        
        return allScratched ? (-1, -1, -1) : (bestResult.0, bestResult.1, bestWind)
    }
    
    var bestResult: String {
        var bestResult = (0, 0.0)
        var bestWind: String? = ""
        var bestFeet = 0
        var bestInches = 0.0
        var allScratched = true
        
        if results.count == 0 {
            return "No Mark"
        }
        
        while allScratched {
            for mark in results {
                if mark.feet != nil {
                    allScratched = false
                }
            }
        }
        
        for mark in results {
            if let currentFeet = mark.feet {
                if currentFeet >= bestFeet {
                    if let currentInches = mark.inches {
                        if currentInches > bestInches || currentFeet > bestFeet {
                            bestFeet = currentFeet
                            bestInches = currentInches
                            bestResult = (currentFeet, currentInches)
                            if let currentWind = mark.wind {
                                bestWind = String(currentWind)
                            } else {
                                bestWind = nil
                            }
                        }
                    }
                }
            }
        }
        
        return allScratched ? "No Mark" : "\(bestResult.0)' \(bestResult.1)\" (\(bestWind ?? "NWI"))"
    }
}
