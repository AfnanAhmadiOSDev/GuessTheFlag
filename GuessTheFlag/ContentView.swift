//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Afnan Ahmad on 03/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    
    @State private var showingGameEnd = false
    @State private var numberOfQuestions = 0
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            //.foregroundStyle(.white)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQueston)
        } message: {
            Text("Your score is \(userScore)")
        }
        
        .alert("Game Over", isPresented: $showingGameEnd) {
            Button("New Game", action: resetGame)
            Button("End Game") {
                numberOfQuestions = 0
            }
        } message: {
            Text("Your Total Score is: \(userScore)/8")
        }
    }//end body
    
    func flagTapped(_ number: Int) {
        numberOfQuestions += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
        }
        
        if numberOfQuestions == 8 {
            showingGameEnd = true
            return
        }
        
        showingScore = true
    }//end method
    
    func askQueston() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }//end method
    
    func resetGame() {
        askQueston()
        userScore = 0
        numberOfQuestions = 0
    }//end method
    
}//end class

#Preview {
    ContentView()
}
