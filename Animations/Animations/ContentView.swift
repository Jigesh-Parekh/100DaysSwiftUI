//
//  ContentView.swift
//  Animations
//
//  Created by Jigesh Parekh on 5/5/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    @State private var rotationAmout = 0.0
    
    var body: some View {
        
        Button(action: {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.rotationAmout += 360
            }
        }) {
            Image("jigIcon")
                .renderingMode(.original).resizable().padding([.top, .leading]).frame(width: 200, height: 200)
        }
        .padding(5)
        .background(Color.gray)
        .foregroundColor(.white)
        .clipShape(Circle()).rotation3DEffect(.degrees(rotationAmout), axis:(x: 0, y: 1, z: 0))
        .overlay(
            Circle()
                .stroke(Color.green)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
