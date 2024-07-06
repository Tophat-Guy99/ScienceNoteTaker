//
//  ContentView.swift
//  L6
//
//  Created by Michael De Beyer on 14/8/23.
//

import SwiftUI

struct Notes: Equatable, Codable {
    var id = UUID()
    var Section: String
    var Title: String
    var Description: String
}

struct Theme {
    var LightMode: String
    var DarkMode: String
}

struct ContentView: View {
    @State var blanktitle = ""
    @State var blankdesc = ""
    @State var hello = "hi"
    @State var SheetShown = false
    
    @AppStorage("Toggle1") var Toggle1 = false
    
    @AppStorage("BGImage") var BGImage = "Ventura light"
    @State var BGImageLocation = 0
    @AppStorage("BGOpacity") var BGOpacity = 20
    
    @State var ThemeArray = [
        Theme(LightMode: "Ventura light", DarkMode: "Ventura dark"),
        Theme(LightMode: "Big Sur light", DarkMode: "Big Sur dark"),
        Theme(LightMode: "Monterey light", DarkMode: "Monterey dark")
    ]
    
    @State var ChemistryArray = [
        Notes(Section: "Chemistry", Title: "Stoichiometry", Description: ""),
        Notes(Section: "Chemistry", Title: "Acids and Bases", Description: ""),
        Notes(Section: "Chemistry", Title: "Salts", Description: "")
    ]
    @State var PhysicsArray = [
        Notes(Section: "Physics", Title: "Turning Effects of Forces", Description: ""),
        Notes(Section: "Physics", Title: "Energy", Description: ""),
        Notes(Section: "Physics", Title: "Pressure", Description: "")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section() {
                        ForEach($ChemistryArray, id: \.id) { $note in
                            NavigationLink {
                                NoteView(Title: $note.Title, Description: $note.Description, Subject: $note.Section, NoteArray: $ChemistryArray, Identity: $note.id, BGImage: $BGImage, BGOpacity: $BGOpacity)
                            } label: {
                                Text(note.Title)
                            }
                        }.onMove {from, to in
                            ChemistryArray.move(fromOffsets: from, toOffset: to)
                            if let CData = try? JSONEncoder().encode(ChemistryArray) {
                                UserDefaults.standard.set(CData, forKey: "C")
                            }
                        }.onDelete { indexSet in
                            ChemistryArray.remove(atOffsets: indexSet)
                            if let CData = try? JSONEncoder().encode(ChemistryArray) {
                                UserDefaults.standard.set(CData, forKey: "C")
                            }
                        }
                    } header: {
                        Text("Chemistry")
                    }
                    Section {
                        ForEach($PhysicsArray, id: \.id) { $note in
                            NavigationLink {
                                NoteView(Title: $note.Title, Description: $note.Description, Subject: $note.Section, NoteArray: $PhysicsArray, Identity: $note.id, BGImage: $BGImage, BGOpacity: $BGOpacity)
                            } label: {
                                Text(note.Title)
                            }
                        }.onMove {from, to in
                            PhysicsArray.move(fromOffsets: from, toOffset: to)
                            if let PData = try? JSONEncoder().encode(PhysicsArray) {
                                UserDefaults.standard.set(PData, forKey: "P")
                            }
                        }.onDelete { indexSet in
                            PhysicsArray.remove(atOffsets: indexSet)
                            if let PData = try? JSONEncoder().encode(PhysicsArray) {
                                UserDefaults.standard.set(PData, forKey: "P")
                            }
                        }
                    } header: {
                        Text("Physics")
                    }
                }
            }
            .sheet(isPresented: $SheetShown) {
                CreateNewView(Title: $blanktitle, Description: $blankdesc, SheetBool: $SheetShown, CArray: $ChemistryArray, PArray: $PhysicsArray, BGImage: $BGImage, BGOpacity: $BGOpacity)
                //NoteView(Title: blankstring, Description: blankstring, Subject: blankstring, notes: Notes)
            }
            .navigationTitle("Science Notes")
            .navigationBarTitleDisplayMode(.large)
            .background {
                Image(BGImage)
                    .opacity(Double(BGOpacity)/20)
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink {
                            SettingsView(Toggle1: $Toggle1, BGImage: $BGImage, SelectedTheme: $ThemeArray, Location: $BGImageLocation, BGOpacity: $BGOpacity)
                        } label: {
                            Image(systemName: "gear")
                                .imageScale(.large)
                        }
                        Button {
                            SheetShown.toggle()
                        } label: {
                            Image(systemName: "plus")
                            
                        }
                    }
                }
                //EditButton()
            }
        }
        .onAppear {
            if let CData = UserDefaults.standard.object(forKey: "C") as? Data,
               let array = try? JSONDecoder().decode([Notes].self, from: CData) {
                ChemistryArray = array
            }
            
            if let PData = UserDefaults.standard.object(forKey: "P") as? Data,
               let array = try? JSONDecoder().decode([Notes].self, from: PData) {
                PhysicsArray = array
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
