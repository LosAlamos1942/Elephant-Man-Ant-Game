//
//  ContentView.swift
//  Elephant, Man, Ant Game
//
//  Created by Induran Aderinto  on 12/15/22.
//

import SwiftUI

enum Choices: String, CaseIterable {
    case Elephant = "🐘", Man = "🧔🏻‍♂️", Ant = "🐜"
}

struct ContentView: View {
    
    @State private var computerChoice = Choices.allCases.first!
    @State private var gameOutcome = ""
    @State private var wins = 0
    @State private var round = 0
    @State private var showAlert = false
    @State private var showComputerChoice = false
    
    
    var body: some View {
        GeometryReader{geo in
            VStack {
                //Computer
                VStack {
                    if !showComputerChoice {
                        Text("🤖")
                            .font(.system(size:100))
                    } else {
                        Text(computerChoice.rawValue)
                            .font(.system(size: 100))
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                //Player
                VStack {
                    
                    Text("Make your Selection:")
                        .font(Font.custom("Baskerville-Bold", size:35))
                        .font(.largeTitle)
                        .padding()
                    HStack(spacing:0){
                        ForEach(Choices.allCases, id:\.self){option in
                            Button(action: {
                                //Start the round
                                round += 1
                                
                                //Generate a computer choice
                                let index = Int.random(in: 0...Choices.allCases.count-1)
                                computerChoice = Choices.allCases[index]
                                showComputerChoice = true
                                
                                // check if you won
                                checkWin(playerChoice: option)
                                
                            }){
                                Text(option.rawValue)}
                            .font(.system(size: geo.size.width/CGFloat(Choices.allCases.count)))
                        }
                    }
                }
                // Counts the number of wins you have and round that you are on
                HStack {
                    Spacer()
                    Text("Wins: \(wins)")
                        .font(Font.custom("Baskerville-Bold", size:20))
                    Spacer()
                    Text("Round: \(round)")
                        .font(Font.custom("Baskerville-Bold", size:20))
                    Spacer()
                }
            }.frame(width: geo.size.width, height: geo.size.height/2)
        }
        // indicates if you win, lose or draw
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            Button("Play Again", role: .cancel){showComputerChoice = false}
        }
        .background(.gray)
    }
    // This function checks who wins based on the player or computer choice. 
    func checkWin(playerChoice:Choices){
        switch playerChoice {
        case .Elephant:
            if computerChoice == .Elephant {
                gameOutcome = "Draw!"
            } else if computerChoice == .Man {
                gameOutcome = "Win!"
                wins += 1
            } else {
                gameOutcome = "Lose!"
            }
        case .Man:
            if computerChoice == .Elephant {
                gameOutcome = "Lose!"
            } else if computerChoice == .Man {
                gameOutcome = "Draw!"
            } else {
                gameOutcome = "Win!"
                wins += 1
            }
        case .Ant:
            if computerChoice == .Elephant {
                gameOutcome = "Win!"
                wins += 1
            } else if computerChoice == .Man {
                gameOutcome = "Lose!"
            } else {
                gameOutcome = "Draw!"
            }
        }
        showAlert = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
