//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Jigesh Parekh on 5/3/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var compRPC = ["Rock", "Paper", "Scissor"]
    
    @State private var compSelection = Int.random(in: 0...2)
    
    @State private var winLose = Bool.random()
    
    @State private var showFinalScore = false
    
    @State private var drawFlag = false
    
    @State private var score = 0
    
    private var rpcKey = [
                
        "Rock"  : "Paper",
        "Paper" : "Scissor",
        "Scissor" : "Rock"
    
    ]
    
    func rpcLogic(computerSelection: String, userInput: String, winLoseLogic: Bool){
        
        if computerSelection == userInput {
            self.drawFlag = true
            self.showFinalScore = true
        }
        else if rpcKey[computerSelection] == userInput && winLoseLogic {
            self.score += 1
        } else if rpcKey[computerSelection] != userInput && !winLoseLogic {
            self.score += 1
        } else {
            self.score -= 1
        }
    }
    
    func gameReset() {
        self.compSelection = Int.random(in: 0...2)
        drawFlag = false
        score = 0
    }
    
    var body: some View {
        
        ZStack
        {
            
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            

            
            VStack(spacing: 30) {
                 
                VStack
                {
                    
                    Text("RockPaperScissors").font(.largeTitle).foregroundColor(Color.black).bold()
                    Text("The Training Game").foregroundColor(Color.black).bold()
                }
                .padding(.top, 25.454)
                
                Spacer()
                
                if winLose {
                    Text("WIN THE GAME")
                        .foregroundColor(Color.black)
                } else {
                    Text("LOSE THE GAME")
                }
               
                
                Image(compRPC[compSelection]).resizable()
                .frame(width: 220, height: 200.0)
                    
                Spacer()
                
                VStack{
                    
                    Text("Select your weapon")
                        .foregroundColor(Color.black)
                        .padding(.top, 0.16)
                
                    HStack {
                        ForEach(0 ..< 3) {  number in
                            Button(action: {
                                self.rpcLogic(computerSelection: self.compRPC[self.compSelection], userInput: self.compRPC[number], winLoseLogic: self.winLose)
                                
                                self.compSelection = Int.random(in: 0...2)
                                
                                if self.score == 10 {
                                    self.showFinalScore = true
                                }
                            }) {
                                Image(self.compRPC[number])
                                    .renderingMode(.original).resizable()
                                    .padding()
                                    .frame(width: 120.2, height: 110.2)
                                    .shadow(color: .black, radius: 9)
                            }
                            
                        }
                    }
                             
                    VStack(spacing: 1.454) {
                        Text("Score: \(score)")
                            .foregroundColor(Color.black)
                    }
                    .padding(.top, 29.404)
                    
                }
                
                Spacer()
                
            }
        }
        .alert(isPresented: $showFinalScore) {
            if drawFlag {
               return Alert(title: Text("DRAW"), message: Text("You did not win or lose, try again "),
                                 dismissButton: .default(Text("Continue")) {
                                   self.gameReset()
                                 })
            } else {
                return Alert(title: Text("Training Complete"), message: Text("Well Done"),
                  dismissButton: .default(Text("Continue")) {
                    self.gameReset()
                  })
            }
        }
       
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
