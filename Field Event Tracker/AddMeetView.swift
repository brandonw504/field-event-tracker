//
//  AddMeetView.swift
//  Field Event Tracker
//
//  Created by Brandon Wong on 4/14/21.
//  Copyright © 2021 Brandon Wong. All rights reserved.
//

import SwiftUI

struct AddMeetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var meets: Meets
    @State private var name = ""
    @State private var date = Date()
    @State private var location = ""
    @State private var schools = [String]()
    @State private var newSchool = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Meet Information")) {
                    TextField("Meet Name", text: $name)
                
                    TextField("Meet Location", text: $location)
                    
                    DatePicker("Meet Date", selection: $date, displayedComponents: [.date])
                }
                
                Section(header: Text("Schools")) {
                    List {
                        ForEach(schools, id: \.self) { school in
                            Text("\(school)")
                        }
                        .onDelete(perform: removeRows)
                        
                        HStack {
                            TextField("School Name", text: $newSchool)
                            
                            Button(action: {
                                if !newSchool.isEmpty {
                                    withAnimation(.default) {
                                        schools.append(newSchool)
                                        newSchool = ""
                                    }
                                }
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Meet")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing:
                Button("Save") {
                    if name.isEmpty || location.isEmpty || schools.isEmpty {
                        showingAlert = true
                    } else {
                        meets.meets.append(Meet(id: meets.meets.count, name: name, location: location, date: date, schools: schools, events: [Event]()))
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("You need to fill out all text fields."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        schools.remove(atOffsets: offsets)
    }
}

struct AddMeet_Previews: PreviewProvider {
    static var previews: some View {
        AddMeetView().environmentObject(Meets())
    }
}
