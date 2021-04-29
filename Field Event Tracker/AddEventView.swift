//
//  AddEventView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/18/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var meets: Meets
    
    let meetID: Int
    
    let events = ["Long Jump", "Triple Jump", "High Jump", "Pole Vault", "Shotput", "Discus", "Javelin", "Hammer"]
    let genders = ["Men", "Women"]
    let divisions = ["Frosh/Soph", "JV", "Varsity"]
    
    @State private var event = 0
    @State private var gender = 0
    @State private var division = 0
    
    var body: some View {
        if meets.meets.count > meetID {
            NavigationView {
                Form {
                    Section(header: Text("Event")) {
                        Picker("Choose Event", selection: $event) {
                            ForEach(0 ..< events.count) {
                                Text("\(events[$0])")
                            }
                        }
                    }
                    
                    Section(header: Text("Gender")) {
                        Picker("Choose Gender", selection: $gender) {
                            ForEach(0 ..< genders.count) {
                                Text("\(genders[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Division")) {
                        Picker("Choose Division", selection: $division) {
                            ForEach(0 ..< divisions.count) {
                                Text("\(divisions[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .navigationTitle("Add Event")
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing:
                    Button("Save") {
                        meets.meets[meetID].events.append(Event(id: meets.meets[meetID].events.count, name: events[event], gender: genders[gender], division: divisions[division], athletes: [Athlete]()))
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(meetID: 0)
    }
}
