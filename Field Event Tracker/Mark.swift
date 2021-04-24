//
//  Mark.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/21/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import Foundation

struct Mark: Identifiable, Codable {
    var id: Int
    var feet: Int?
    var inches: Double?
    var wind: Double?
}
