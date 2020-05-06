//
//  ContentView.swift
//  WordScramble
//
//  Created by Jigesh Parekh on 5/4/20.
//  Copyright © 2020 Jigesh Parekh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
     
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    var body: some View {
        
        NavigationView{
            ZStack {
                
                VStack{
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord).textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none).padding()
                    
                    List(usedWords, id: \.self) {
                        Image(systemName: "\($0.count).circle")
                        Text($0)
                    }
                }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
                VStack{
                Spacer()
                    VStack{
                        HStack {
                            Spacer()
                            Button(action: {
                                self.startGame()
                                }) {
                                    HStack {
                                        Image(systemName: "livephoto")
                                           .font(.title)
                                        Text("Next Word")
                                           .fontWeight(.semibold)
                                           .font(.body)
                                   }
                                   .padding()
                                   .foregroundColor(.white)
                                   .background(Color.blue)
                                   .cornerRadius(40)
                               }
                               
                           }
                        
                        
                        HStack {
                            Text("Score: \(score)").fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: 150, height: 50, alignment: .bottomLeading)
                                .background(Color.gray)
                                .cornerRadius(40).padding()
                            Spacer()
                            Button(action: {
                                self.startGame()
                            }) {
                                HStack {
                                    Image(systemName: "livephoto")
                                        .font(.title)
                                    Text("      Restart")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(40)
                            }
                            
                        }
                    }
                }
            }
            
        }
        .padding(.trailing)
    }
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try harder")
            newWord = ""
            score = 0
            return
        }
        
        guard isPossible(word: answer) else {
            newWord = ""
            wordError(title: "Word not Recognized", message: "Try again")
            newWord = ""
            score = 0
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Not a real word", message: "Either the word is not real or its under 3 characters, try harder!")
            newWord = ""
            score = 0
            return
        }
        
        score += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL =
            Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try?
                String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                newWord = ""
                usedWords = [String]()
                return
            }
        }
        
        fatalError("could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if word.count < 3 {
            return false
        }
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
