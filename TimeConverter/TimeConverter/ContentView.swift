//
//  ContentView.swift
//  TimeConverter
//
//  Created by Jigesh Parekh on 4/27/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var timeInSeconds = ""
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    var timeConverter: String {
        let timeConverted = secondsToHoursMinutesSeconds(seconds: Int(timeInSeconds) ?? 0)
        
        return String(format: "%02d:%02d", timeConverted.1, timeConverted.2)
    }
    
    
    var body: some View {
        
        NavigationView{
            Form {
                TextField("Enter Your time in seconds here", text: $timeInSeconds).keyboardType(.numberPad)
                
                Text("Time Converted: \(timeConverter)")
            }
        .navigationBarTitle(Text("TimeConverter"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
