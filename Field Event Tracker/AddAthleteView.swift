//
//  AddAthleteView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/18/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

struct AddAthleteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var meets: Meets
    
    let meetID: Int
    let eventID: Int
    
    @State private var name = ""
    @State private var school = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Section(header: Text("Choose School")) {
                    Picker("Choose School", selection: $school) {
                        ForEach(0 ..< meets.meets[meetID].schools.count) {
                            Text("\(meets.meets[meetID].schools[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add Athlete")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing:
                Button("Save") {
                    if !name.isEmpty {
                        meets.meets[meetID].events[eventID].athletes.append(Athlete(id: meets.meets[meetID].events[eventID].athletes.count, name: name, school: meets.meets[meetID].schools[school], results: [Mark](), resultsString: [String]()))
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
        .environmentObject(meets)
    }
}

struct AddAthleteView_Previews: PreviewProvider {
    static var previews: some View {
        AddAthleteView(meetID: 0, eventID: 0)
    }
}
