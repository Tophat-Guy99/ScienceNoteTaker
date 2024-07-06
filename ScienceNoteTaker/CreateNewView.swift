//
//  CreateNewView.swift
//  L6
//
//  Created by Michael De Beyer on 15/8/23.
//

import SwiftUI

struct CreateNewView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var Title: String
    @Binding var Description: String
    @Binding var SheetBool: Bool
    @Binding var CArray: Array<Notes>
    @Binding var PArray: Array<Notes>
    @Binding var BGImage: String
    @Binding var BGOpacity: Int
    
    enum Subject: String, CaseIterable, Identifiable {
        case Chemistry, Physics
        var id: Self { self }
    }
    
    
    @State private var selectedSubject: Subject = .Chemistry
    
    
    var body: some View {
        List {
            Section {
                TextField("Enter Title", text: $Title)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                
                Picker("Subject", selection: $selectedSubject) {
                    Text("Chemistry").tag(Subject.Chemistry)
                    Text("Physics").tag(Subject.Physics)
                }
            }
            Section {
                TextEditor(text: $Description)
            } header: {
                Text("Type your notes below")
            }
            Section {
                Button {
                    if selectedSubject == .Chemistry {
                        CArray.append(Notes(Section: selectedSubject.rawValue, Title: Title, Description: Description))
                        if let CData = try? JSONEncoder().encode(CArray) {
                            UserDefaults.standard.set(CData, forKey: "C")
                        }
                        
                    } else if selectedSubject == .Physics {
                        PArray.append(Notes(Section: selectedSubject.rawValue, Title: Title, Description: Description))
                        if let PData = try? JSONEncoder().encode(PArray) {
                            UserDefaults.standard.set(PData, forKey: "P")
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Create")
                        .foregroundColor(.green)
                        .frame(alignment: .center)
                }
                
                Button(role: .cancel) {
                    SheetBool.toggle()
                    Description = ""
                    Title = ""
                } label: {
                    Text("Cancel")
                        .frame(alignment: .center)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background {
            Image(BGImage)
        }
    }
}

struct CreateNewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewView(Title: .constant(""), Description: .constant(""), SheetBool: .constant(true), CArray: .constant([Notes(Section: "Chemistry", Title: "Title", Description: "Desc")]), PArray: .constant([Notes(Section: "Chemistry", Title: "Title", Description: "Desc")]), BGImage: .constant(""), BGOpacity: .constant(1))
    }
}
