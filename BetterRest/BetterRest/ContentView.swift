//
//  ContentView.swift
//  BetterRest
//
//  Created by Jigesh Parekh on 5/3/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUP = Date()
    
    var body: some View {
        VStack {
            Form {
                DatePicker("Please Enter a Date", selection: $wakeUP)
            }
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g")")
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
