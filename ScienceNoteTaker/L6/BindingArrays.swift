//
//  BindingArrays.swift
//  L6
//
//  Created by Michael De Beyer on 14/8/23.
//

import SwiftUI

struct Person {
    var id = UUID()
    var name: String
    var age: Int
}
struct BindingArrays: View {
    @State var PersonArray = [
        Person(name: "person", age: 3),
        Person(name: "human", age: 5)
        ]
    var body: some View {
        VStack {
            ForEach($PersonArray, id: \.id) { $person in
                DetailView(BindedHello: $person.name)
            }
        }
    }
}

struct BindingArrays_Previews: PreviewProvider {
    static var previews: some View {
        BindingArrays()
    }
}
