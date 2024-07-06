//
//  NoteView.swift
//  L6
//
//  Created by Michael De Beyer on 14/8/23.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var Title: String
    @Binding var Description: String
    @Binding var Subject: String
    @Binding var NoteArray: Array<Notes>
    @Binding var Identity: UUID
    @Binding var BGImage: String
    @Binding var BGOpacity: Int
    @State private var arrindex = 0
    
    @State private var AlertShown = false
    
    var body: some View {
        List {
            Section {
                TextField("Enter Title", text: $Title)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .onChange(of: Title) { Newtitle in
                        let SavedSubject: String = Subject
                        let SavedArray = NoteArray
                        if SavedSubject == "Chemistry" {
                            if let CData = try? JSONEncoder().encode(SavedArray) {
                                UserDefaults.standard.set(CData, forKey: "C")
                            }
                        } else if SavedSubject == "Physics" {
                            if let PData = try? JSONEncoder().encode(SavedArray) {
                                UserDefaults.standard.set(PData, forKey: "P")
                            }
                        }
                    }
                Text("Subject: " + Subject)
            }
            Section {
                TextEditor(text: $Description)
                    .onChange(of: Description) { Newdesc in
                        let SavedSubject: String = Subject
                        let SavedArray = NoteArray
                        if SavedSubject == "Chemistry" {
                            if let CData = try? JSONEncoder().encode(SavedArray) {
                                UserDefaults.standard.set(CData, forKey: "C")
                            }
                        } else if SavedSubject == "Physics" {
                            if let PData = try? JSONEncoder().encode(SavedArray) {
                                UserDefaults.standard.set(PData, forKey: "P")
                            }
                        }
                    }
            } header: {
                Text("Type your notes below")
            }
            Section {
                Button (role: .destructive){
                    AlertShown.toggle()
                    print(Subject)
                } label: {
                    Text("Delete")
                        .alert(isPresented: $AlertShown) {
                            Alert(
                                title: Text("Are you sure you want to delete this?"),
                                message: Text("This action is irreversible."),
                                primaryButton: .destructive(Text("Delete")) {
                                    for i in NoteArray {
                                        if i.id == Identity {
                                            let SavedSubject: String = Subject
                                            arrindex = NoteArray.firstIndex(of: i) ?? 0
                                            NoteArray.remove(at: arrindex)
                                            let SavedArray = NoteArray
                                            
                                            
                                            if SavedSubject == "Chemistry" {
                                                if let CData = try? JSONEncoder().encode(SavedArray) {
                                                    UserDefaults.standard.set(CData, forKey: "C")
                                                }
                                            } else if SavedSubject == "Physics" {
                                                if let PData = try? JSONEncoder().encode(SavedArray) {
                                                    UserDefaults.standard.set(PData, forKey: "P")
                                                }
                                            }
                                            presentationMode.wrappedValue.dismiss()
                                            break
                                            
                                        }
                                    }
                                },
                                secondaryButton: .cancel()
                            )
                        }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background {
            Image(BGImage)
                .opacity(Double(BGOpacity)/20)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(Title: .constant(""), Description: .constant(""), Subject: .constant(""), NoteArray: .constant([Notes(Section: "Chemistry", Title: "Title", Description: "Desc")]), Identity: .constant(UUID()), BGImage: .constant(""), BGOpacity: .constant(1))
    }
}
