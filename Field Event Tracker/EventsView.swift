//
//  EventsView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/16/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

struct EventsView: View {
    var meetID: Int
    
    @EnvironmentObject var meets: Meets
    
    @State private var showingAddEventView = false
    
    var body: some View {
        Form {
            ForEach(meets.meets[meetID].events) { event in
                NavigationLink(destination: AthleteView(meetID: meetID, eventID: event.id, event: event.name)) {
                    VStack(alignment: .leading) {
                        Text("\(event.division) \(event.name)")
                            .font(.headline)
                        Text("\(event.gender)")
                    }
                }
            }
            .onDelete(perform: removeRows)
        }
        .navigationTitle("Events")
        .navigationBarItems(trailing:
            Button(action: {
                showingAddEventView = true
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $showingAddEventView) {
            AddEventView(meetID: meetID)
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        meets.meets[meetID].events.remove(atOffsets: offsets)
        offsets.forEach {
            meets.meets[meetID].events.remove(at: $0)
            for i in $0 ..< meets.meets[meetID].events.count {
                meets.meets[meetID].events[i].id -= 1
            }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(meetID: 0)
    }
}
