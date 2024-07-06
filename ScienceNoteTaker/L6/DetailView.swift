//
//  DetailView.swift
//  L6
//
//  Created by Michael De Beyer on 14/8/23.
//

import SwiftUI

struct DetailView: View {
    @Binding var BindedHello: String
    var body: some View {
        Text(BindedHello)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(BindedHello: .constant("hello"))
    }
}
