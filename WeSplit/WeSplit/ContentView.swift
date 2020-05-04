//
//  ContentView.swift
//  TipSplitter
//
//  Created by Jigesh Parekh on 4/27/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var isNoTip = false
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        //calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0.0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal  = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var tipValue: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0.0
        let tipVal = ((orderAmount / 100 * tipSelection) / peopleCount)
        return tipVal
    }
    
    var orderAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let orderAmount = Double(checkAmount) ?? 0.0
        
        let grandTotal  = orderAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var costOfFoodWithTip: Double {
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0.0
        
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal  = orderAmount + tipValue
       
        return grandTotal
        
    }

    var body: some View {
        
        VStack {
            NavigationView {
            Form {
                
                Section {
                    TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                    
                    
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2 ..< 40 ) {
                            Text("\($0) people")
                        }
                    }
                }.onTapGesture {
                        self.endEditing()
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentages", selection: $tipPercentage){
                        ForEach( 0 ..< tipPercentages.count ) {
                            Text("\(self.tipPercentages[$0])%")
                            
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Tip Value: ")) {
                    Text("$\(tipValue, specifier: "%.2f")")
                }
                
                Section(header: Text("Order Amount: ")) {
                    Text("$\(orderAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Review of Check information")) {
                    VStack{
                        HStack{
                        Text("Amount Per Person")
                        .multilineTextAlignment(.leading)
                        .padding([.top, .bottom, .trailing])
                        .frame(height: 0.0)
                        
                        Spacer()
                        
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                            .multilineTextAlignment(.trailing)
                            .padding(.leading)
                        }
                            
                    
                    

                        HStack{
                            Text("Grand Total")
                                           .multilineTextAlignment(.leading)
                                           .padding([.top, .bottom, .trailing])
                                           .frame(height: 0.0)
                                .foregroundColor(tipPercentage == 4 ? .red : .blue)
                                           
                            Spacer()
                                               
                            Text("$\(costOfFoodWithTip, specifier: "%.2f")")
                                               .multilineTextAlignment(.trailing)
                                               .padding(.leading)
                                               
                        }
                        
                    }
                
                }
                    
            
              
            
            } .navigationBarTitle("WeSplit")
            }
            
        }
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

