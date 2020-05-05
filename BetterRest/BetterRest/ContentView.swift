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
    @State private var wakeUP = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form{
                    VStack(alignment: .leading, spacing: 0){
                        Text("When Do you want to wake up?").font(.headline)
                        
                        DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("Desired amount of sleep")
                        
                        Stepper(value: $sleepAmount, in: 4...12) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    VStack(alignment: .leading, spacing: 0){
                        Text("Amount of Coffee Consumed")
                        
                        Stepper(value: $coffeeAmount, in: 1...20) {
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing: Button(action: calculateBedtime) { Text("Calculate") } )
            
            .alert(isPresented: $showingAlert ) {
                Alert(title: Text(alertTitle), message:  Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUP)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let min = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + min), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUP - prediction.actualSleep
            
            let formatter = DateFormatter()
            
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal time to sleep is: "
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
