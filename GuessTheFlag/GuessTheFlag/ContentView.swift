//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jigesh Parekh on 4/28/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries  = ["estonia", "france", "germany", "ireland",
        "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var pointConnter = 0
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
        
            
            //Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                
                VStack{
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
                }
                
             
            
                ForEach(0 ..< 3) {  number in
                    Button(action: {
                        //flag was tapped
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original).clipShape(Capsule())
                                
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        
                            .shadow(color: .black, radius: 9)
                    }
                    
                }
                
                
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Yout Schore is \(pointConnter)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            pointConnter += 1
        } else {
            scoreTitle = "Wrong Flag, that is the flag of \(countries[number])"
            pointConnter -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
