//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jigesh Parekh on 4/28/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI


struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 9)
    }
}

struct ContentView: View {
    
    @State private var countries  = ["estonia", "france", "germany", "ireland",
        "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var pointConnter = 0
    
    @State private var opacityAmount = 1.0
    @State private var rotationAmount = 0.0
    @State private var wrongRotationAmount = [0.0, 0.0, 0.0]
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                
                VStack{
                    Text("Tap the flag of").foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
             
            
                ForEach(0 ..< 3) {  number in
                    Button(action: {
                        //flag was tapped
                        self.opacityAmount = 0.2
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                        .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                        .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotationAmount : 0),axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees(self.wrongRotationAmount[number]),axis: (x: 0, y: 1, z: 0))
                    
                }
                
                
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your Score is \(pointConnter)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            pointConnter += 1
            
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.rotationAmount = 360
            }
        } else {
            scoreTitle = "Wrong Flag, that is the flag of \(countries[number])"
            pointConnter -= 1
            
            withAnimation(Animation.interpolatingSpring(mass: 1, stiffness: 120, damping: 40, initialVelocity: 200)) {
                self.wrongRotationAmount[number] = 5
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation(.easeInOut) {
            self.opacityAmount = 1.0
        }
        self.rotationAmount = 0.0
        wrongRotationAmount = Array(repeating: 0.0, count: 3)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
