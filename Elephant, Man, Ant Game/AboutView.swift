//
//  AboutView.swift
//  Elephant, Man, Ant Game
//
//  Created by Induran Aderinto  on 12/16/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Text("What is Elephant, Man, Ant?")
            .font(.title)
            .padding()
        Text("Elephant, Man, Ant is a variation of rock paper, scissors played in Indonesia. In this variaton of the popular hand game, you use your thumb (elephant), forefinger (person), and pinky (ant). The elephant beats the man, the man beats the ant, and the ant beats the elephant. ")
            .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
