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
    @State private var showingAlert = false
    
    var body: some View {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                NavigationView {
                    Form {
                        TextField("Name", text: $name)
                        
                        Section(header: Text("Choose School")) {
                            if meets.meets[meetID].schools.count > 3 {
                                Picker("Choose School", selection: $school) {
                                    ForEach(0 ..< meets.meets[meetID].schools.count) {
                                        Text("\(meets.meets[meetID].schools[$0])")
                                    }
                                }
                            } else {
                                Picker("Choose School", selection: $school) {
                                    ForEach(0 ..< meets.meets[meetID].schools.count) {
                                        Text("\(meets.meets[meetID].schools[$0])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    }
                    .navigationTitle("Add Athlete")
                    .navigationBarItems(leading: Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }, trailing:
                        Button("Save") {
                            if name.isEmpty {
                                showingAlert = true
                            } else {
                                meets.meets[meetID].events[eventID].athletes.append(Athlete(id: meets.meets[meetID].events[eventID].athletes.count, name: name, school: meets.meets[meetID].schools[school], results: [Mark](), resultsString: [String]()))
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    )
                }
                .environmentObject(meets)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("You need to enter the athlete's name."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct AddAthleteView_Previews: PreviewProvider {
    static var previews: some View {
        AddAthleteView(meetID: 0, eventID: 0)
    }
}
