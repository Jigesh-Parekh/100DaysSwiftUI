//
//  AddView.swift
//  iExpense
//
//  Created by Jigesh Parekh on 5/13/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "personal"
    @State private var amount = ""
    
    static let types = ["Business","Personal"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount).keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
            
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpensesItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}