//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Jigesh Parekh on 5/3/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var compRPC = ["Rock", "Paper", "Scissor"].shuffled()
    
    
    
    var body: some View {
        ZStack
        {
            
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            

            
            VStack(spacing: 50) {
                 
                VStack
                {
                    
                    Text("RockPaperScissors").font(.largeTitle).bold()
                    Text("The Game").bold()
                }
                .padding(.top, 25.454)
                
                Spacer()
                
                Image("Paper").resizable()
                .frame(width: 200, height: 200.0)
                    
                Spacer()
                
                VStack{
                    
                    Text("Select your weapon")
                        .padding(.top, 0.16)
                
                    HStack {
                        Spacer()
                        
                        Image("Rock").resizable()
                            .frame(width: 51.2, height: 51.2)
                        Spacer()
                        
                        Image("Paper").resizable()
                                           .frame(width: 51.2, height: 51.2)
                        Spacer()
                        
                        Image("Scissor").resizable()
                                           .frame(width: 58.2, height: 51.2)
                        Spacer()
                    }
                   
                    
                   
                    
                   
                    VStack(spacing: 1.454) {
                        Text("Score")
                    }
                    .padding(.top, 29.404)
                    
                }
                
                Spacer()
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
