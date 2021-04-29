//
//  ResultsView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/16/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var meets: Meets
    
    let meetID: Int
    let eventID: Int
    
    @State private var reinvokeBody = false
    
    var body: some View {
        if meets.meets.count > meetID {
            if meets.meets[meetID].events.count > eventID {
                NavigationView {
                    List {
                        if meets.meets[meetID].events[eventID].athletes.isEmpty {
                            Text("No results to display.")
                        } else {
                            ForEach(meets.meets[meetID].events[eventID].athletesRanked) { athlete in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(athlete.name)")
                                            .font(.headline)
                                        Text("\(athlete.school)")
                                    }
                                    Spacer()
                                    Text("\(athlete.bestResult)")
                                }
                            }
                        }
                    }
                    .navigationTitle("Results")
                    .navigationBarItems(trailing:
                        Button("Done") {
                            reinvokeBody.toggle()
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(meetID: 0, eventID: 0)
    }
}
