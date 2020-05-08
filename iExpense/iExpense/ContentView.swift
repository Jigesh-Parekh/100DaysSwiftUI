//
//  ContentView.swift
//  iExpense
//
//  Created by Jigesh Parekh on 5/6/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
        Text("\(user.firstName)")
            TextField("", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
