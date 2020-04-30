//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jigesh Parekh on 4/29/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some  View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) {column in
                        self.content(row, column)
                        }
                }
            }
        }
    }
}

//custom view modifier 
struct TitleBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
        .padding()
            .background(Color.green)
    }
}

struct ContentView: View {
    //computed property
    var motto1: some View { Text("yolo") }
    let motto2 = Text("dolo")
    
    var body: some View {
        
        
        //Text("Hello, World!")
        VStack {
            
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("wtf")
                }
            }
            
        Button("Hello World") {
            //
        }
        .frame(width: 200, height: 200)
        .background(Color.red)
        .cornerRadius(/*@START_MENU_TOKEN@*/0.018/*@END_MENU_TOKEN@*/)
        
            VStack {
                motto1.modifier(TitleBlue())
                motto2.foregroundColor(.blue)
            }
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
