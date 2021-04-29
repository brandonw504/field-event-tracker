//
//  AthleteView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/16/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case results, addAthlete
    
    var id: Int {
        hashValue
    }
}

struct AthleteView: View {
    let meetID: Int
    let eventID: Int
    let event: String
    
    @EnvironmentObject var meets: Meets
    
    @State private var newAthlete = ""
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                Form {
                    ForEach(meets.meets[meetID].events[eventID].athletes) { athlete in
                        NavigationLink(destination: EnterMarksView(meetID: meetID, eventID: eventID, athleteID: athlete.id)) {
                            VStack(alignment: .leading) {
                                Text("\(athlete.name)")
                                    .font(.headline)
                                Text("\(athlete.school)")
                            }
                        }
                    }
                    .onDelete(perform: removeRows)
                    
                    Button("Add Athlete") {
                        activeSheet = .addAthlete
                    }
                }
                .navigationTitle("\(event)")
                .navigationBarItems(trailing:
                    Button("Results") {
                        activeSheet = .results
                    }
                )
                .sheet(item: $activeSheet) { item in
                    switch item {
                    case .results:
                        ResultsView(meetID: meetID, eventID: eventID)
                    case .addAthlete:
                        AddAthleteView(meetID: meetID, eventID: eventID)
                    }
                }
                .environmentObject(meets)
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                offsets.forEach {
                    meets.meets[meetID].events[eventID].athletes.remove(at: $0)
                    for i in $0 ..< meets.meets[meetID].events[eventID].athletes.count {
                        meets.meets[meetID].events[eventID].athletes[i].id -= 1
                    }
                }
            }
        }
    }
}

struct AthleteView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteView(meetID: 0, eventID: 0, event: "Long Jump")
    }
}
