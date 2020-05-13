//
//  ContentView.swift
//  iExpense
//
//  Created by Jigesh Parekh on 5/6/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI


//global classes

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

//local struct


struct ContentView: View {
    @State private var showSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNum  = 1
    @State private var tapCount  = UserDefaults.standard.integer(forKey: "Tap")
    var body: some View {
        NavigationView{
            VStack {
                List {
                    Text("TapCount: \(self.tapCount)")
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Numbers") {
                    self.numbers.append(self.currentNum)
                    self.currentNum += 1
                }
                Button("TapCount") {
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }
            }
            .navigationBarItems(leading: EditButton())
        }
        
    }

    func removeRows(at offsets: IndexSet) {
          numbers.remove(atOffsets: offsets)
      }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
