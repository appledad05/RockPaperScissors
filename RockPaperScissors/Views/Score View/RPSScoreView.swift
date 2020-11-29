//
//  RPSScoreView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI

struct RPSScoreView: View {
    @Binding var gameScore: Int
    @Binding var playerScore: Int
    
    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 5) {
                Text("Player").font(.title)
                Text("\(playerScore)")
                    .font(.title2).fontWeight(.black)
            }
            
            Spacer()
            
            VStack(spacing: 5) {
                Text("Game").font(.title)
                Text("\(gameScore)")
                    .font(.title2).fontWeight(.black)
            }

            Spacer()
        }
    }
}

struct RPSScoreView_Previews: PreviewProvider {
    static var previews: some View {
        RPSScoreView(gameScore: .mock(10), playerScore: .mock(10))
    }
}
