//
//  Model.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 8/25/20.
//  Copyright © 2020 Brandon Wong. All rights reserved.
//

import Foundation

struct Meet: Identifiable, Codable {
    var id: Int
    var name: String
    var location: String
    var date: Date
    var schools: [String]
    var events: [Event]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

class Meets: ObservableObject {
    @Published var meets = [Meet]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(meets) {
                UserDefaults.standard.set(encoded, forKey: "Meets")
            }
        }
    }
    
    init() {
        if let meets = UserDefaults.standard.data(forKey: "Meets") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Meet].self, from: meets) {
                self.meets = decoded
                return
            }
        }
        
        self.meets = []
    }
}
