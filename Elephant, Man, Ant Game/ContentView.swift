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
    
    @State var computerChoice = Choices.allCases.first!
    @State var gameOutcome = ""
    
    @State var wins = 0
    @State var round = 0
    
    @State var showAlert = false
    @State var showComputerChoice = false
    
    
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
                        .font(.title)
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
                HStack {
                    Spacer()
                    Text("Wins: \(wins)")
                    Spacer()
                    Text("Round: \(round)")
                    Spacer()
                    
                }
            }.frame(width: geo.size.width, height: geo.size.height/2)
        }
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            Button("Play Again", role: .cancel){showComputerChoice = false}
        }
    }
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
