//
//  SettingsView.swift
//  L6
//
//  Created by Michael De Beyer on 21/8/23.
//

import SwiftUI



struct SettingsView: View {
    @Binding var Toggle1: Bool
    @Binding var BGImage: String
    @Binding var SelectedTheme: Array<Theme>
    @Binding var Location: Int
    @Binding var BGOpacity: Int
    
    var body: some View {
        NavigationStack {
            
            List {
                Section {
                    VStack {
                        Menu {
                            Text("Theme will be affected by dark mode")
                            Divider()
                            Button {
                                Location = 0
                                if Toggle1 == true {
                                    BGImage = SelectedTheme[Location].DarkMode
                                } else {
                                    BGImage = SelectedTheme[Location].LightMode
                                }
                                
                            } label: {
                                Text("Ventura")
                            }
                            
                            Button {
                                Location = 1
                                if Toggle1 == true {
                                    BGImage = SelectedTheme[Location].DarkMode
                                } else {
                                    BGImage = SelectedTheme[Location].LightMode
                                }
                            } label: {
                                Text("Big Sur")
                            }
                            Button {
                                Location = 2
                                if Toggle1 == true {
                                    BGImage = SelectedTheme[Location].DarkMode
                                } else {
                                    BGImage = SelectedTheme[Location].LightMode
                                }
                            } label: {
                                Text("Monterey")
                            }
                        } label: {
                            HStack {
                                Text("Color Theme: ")
                                Spacer()
                            }
                            .padding(-2.5)
                            .padding(.top, 11.0)
                            .padding(.bottom, 11.0)
                            
                        }
                        Toggle(isOn: $Toggle1) {
                            Text("Dark Mode Variants Enabled")
                        }
                        .onChange(of: Toggle1) { value in
                            if value == true {
                                BGImage = SelectedTheme[Location].DarkMode
                                //UINavigationBar.appearance().tintColor = UIColor.white
                            } else {
                                BGImage = SelectedTheme[Location].LightMode
                                //UINavigationBar.appearance().tintColor = UIColor.black
                            }
                        }
                        Stepper(("Wallpaper Opacity: \(String(format: "%.0f", (Double(BGOpacity)/20)*100))%"), value: $BGOpacity, in: 0...20)
                        
                    }
                } header: {
                    Text("Decorative Changes")
                }
            }
            .navigationTitle("Settings")
        }
        .background {
            Image(BGImage)
                .opacity(Double(BGOpacity)/20)
        }
        .scrollContentBackground(.hidden)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(Toggle1: .constant(false), BGImage: .constant(""), SelectedTheme: .constant([]), Location: .constant(0), BGOpacity: .constant(1))
    }
}
