//
//  ContentView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 8/25/20.
//  Copyright © 2020 Brandon Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var meets = Meets()
    @State private var showingAddMeet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(meets.meets) { meet in
                    NavigationLink(destination: EventsView(meetID: meet.id)) {
                        VStack(alignment: .leading) {
                            Text(meet.name)
                                .font(.headline)
                            Text(meet.formattedDate)
                        }
                    }
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Meets")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    showingAddMeet = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddMeet) {
                AddMeetView()
            }
        }
        .environmentObject(meets)
    }
    
    func removeRows(at offsets: IndexSet) {
        offsets.forEach {
            meets.meets.remove(at: $0)
            for i in $0 ..< meets.meets.count {
                meets.meets[i].id -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
