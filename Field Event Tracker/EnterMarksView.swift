//
//  EnterMarksView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/16/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

struct EnterMarksView: View {
    let meetID: Int
    let eventID: Int
    let athleteID: Int
    
    @EnvironmentObject var meets: Meets
    
    let inchesIncrements = Array(stride(from: 0.0, to: 11.75, by: 0.25))
    let windIncrements = Array(stride(from: -5.0, through: 5.0, by: 0.1))
    
    @State private var feet = 0
    @State private var inches = 0
    @State private var wind = 0
    @State private var hasWind = true
    @State private var scratch = false
    
    var body: some View {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                if meets.meets[meetID].events[eventID].athletes.count > athleteID {
                    Form {
                        Section(header: Text("Marks")) {
                            List {
                                ForEach(meets.meets[meetID].events[eventID].athletes[athleteID].resultsString, id: \.self) { result in
                                    Text("\(result)")
                                }
                                .onDelete(perform: removeRows)
                            }
                        }

                        Section(header: Text("Enter Marks")) {
                            List {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Toggle("Scratch", isOn: $scratch)
                                        if !scratch {
                                            Spacer()
                                            Divider()
                                            Spacer()
                                            Toggle("Wind", isOn: $hasWind)
                                        }
                                    }
                                    
                                    if !scratch {
                                        HStack {
                                            Picker("Select Feet", selection: $feet) {
                                                ForEach(0 ..< 351) {
                                                    Text("\($0)")
                                                }
                                            }
                                            .pickerStyle(MenuPickerStyle())
                                            Spacer()
                                            Text("\(feet)")
                                        }
                                        
                                        HStack {
                                            Picker("Select Inches", selection: $inches) {
                                                ForEach(0 ..< inchesIncrements.count) {
                                                    Text("\(inchesIncrements[$0], specifier: "%.2f")")
                                                }
                                            }
                                            .pickerStyle(MenuPickerStyle())
                                            Spacer()
                                            Text("\(inchesIncrements[inches], specifier: "%.2f")")
                                        }

                                        if hasWind {
                                            HStack {
                                                Picker("Select Wind", selection: $wind) {
                                                    ForEach(0 ..< windIncrements.count) {
                                                        Text("\(windIncrements[$0], specifier: "%.1f")")
                                                    }
                                                }
                                                .pickerStyle(MenuPickerStyle())
                                                Spacer()
                                                Text("\(windIncrements[wind], specifier: "%.1f")")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Button("Add Mark") {
                                withAnimation(.default) {
                                    if scratch {
                                        meets.meets[meetID].events[eventID].athletes[athleteID].results.append(Mark(id: meets.meets[meetID].events[eventID].athletes[athleteID].results.count, feet: nil, inches: nil, wind: nil))
                                        meets.meets[meetID].events[eventID].athletes[athleteID].resultsString.append("Scratch")
                                    } else if !hasWind {
                                        meets.meets[meetID].events[eventID].athletes[athleteID].results.append(Mark(id: meets.meets[meetID].events[eventID].athletes[athleteID].results.count, feet: feet, inches: inchesIncrements[inches], wind: nil))
                                        meets.meets[meetID].events[eventID].athletes[athleteID].resultsString.append("\(String(feet))' \(String(inchesIncrements[inches]))\"")
                                    } else {
                                        meets.meets[meetID].events[eventID].athletes[athleteID].results.append(Mark(id: meets.meets[meetID].events[eventID].athletes[athleteID].results.count, feet: feet, inches: inchesIncrements[inches], wind: windIncrements[wind].rounded(toPlaces: 1)))
                                        meets.meets[meetID].events[eventID].athletes[athleteID].resultsString.append("\(String(feet))' \(String(inchesIncrements[inches]))\" (\(String(windIncrements[wind].rounded(toPlaces: 1))))")
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Enter Information")
                    .environmentObject(meets)
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                if meets.meets[meetID].events[eventID].athletes.count > athleteID {
                    offsets.forEach {
                        meets.meets[meetID].events[eventID].athletes[athleteID].results.remove(at: $0)
                        meets.meets[meetID].events[eventID].athletes[athleteID].resultsString.remove(at: $0)
                        for i in $0 ..< meets.meets[meetID].events[eventID].athletes[athleteID].results.count {
                            meets.meets[meetID].events[eventID].athletes[athleteID].results[i].id -= 1
                        }
                    }
                }
            }
        }
    }
}

struct EnterMarksView_Previews: PreviewProvider {
    static var previews: some View {
        EnterMarksView(meetID: 0, eventID: 0, athleteID: 0)
    }
}
