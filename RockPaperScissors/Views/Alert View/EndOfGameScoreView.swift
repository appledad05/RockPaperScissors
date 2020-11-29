//
//  EndOfGameScoreView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/29/20.
//

import SwiftUI

struct EndOfGameScoreView: View {
    @Binding var isPresented: Bool
    @Binding var howdYouDo: String
    @Binding var totalQuestions: Int
    @Binding var playerScore: Int
    @Binding var gameScore: Int
    @Binding var gameStarted: Bool
    
    var body: some View {
        VStack {
            ImageView(howYouDid: $howdYouDo)
            MessageView(playersScore: $playerScore)
                .padding()
            ButtonView(isPresented: $isPresented, totalQuestions: $totalQuestions, playerScore: $playerScore, gameScore: $gameScore, howDidIDo: $howdYouDo, gameStarted: $gameStarted)
                .padding()
            Spacer()
            
        }
        .frame(width: 330, height: 490)
        .background(Color.white)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct EndOfGameScoreView_Previews: PreviewProvider {
    static var previews: some View {
        EndOfGameScoreView(isPresented: .mock(true), howdYouDo: .mock("ThumbsUp"), totalQuestions: .mock(0), playerScore: .mock(0), gameScore: .mock(0), gameStarted: .mock(true))
    }
}

struct ImageView: View {
    @Binding var howYouDid: String
    var body: some View {
        ZStack {
            VStack {
                Image(howYouDid)
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .shadow(radius: 5).shadow(radius: 5).shadow(radius: 5)
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .background(Color.gray)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(howYouDid: .mock("ThumbsUp"))
    }
}

struct MessageView: View {
    @Binding var playersScore: Int

    var body: some View {
        VStack(alignment: .center) {
            Text("Game Over")
                .font(.title).bold()
                .padding(.bottom, 10)
            
            VStack(alignment: .center) {
                Text("You scored").font(.title3)
                Text("\(playersScore)").font(.largeTitle).fontWeight(.black)
                    .padding(5)
                
                Text("out of 10").font(.title3)
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(playersScore: .mock(8))
    }
}

struct ButtonView: View {
    @Binding var isPresented: Bool
    @Binding var totalQuestions: Int
    @Binding var playerScore: Int
    @Binding var gameScore: Int
    @Binding var howDidIDo: String
    @Binding var gameStarted: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                self.isPresented.toggle()
                self.totalQuestions = 10
                self.playerScore = 0
                self.gameScore = 0
                self.howDidIDo = ""
                self.gameStarted.toggle()
            }, label: {
                Text("Close")
                    .bold()
                    .frame(width: 230, height: 50)
                    .foregroundColor(Color.white)
                    .background(Color.purple)
                    .cornerRadius(8)
            })
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isPresented: .mock(true), totalQuestions: .mock(0), playerScore: .mock(0), gameScore: .mock(0), howDidIDo: .mock("ThumbsUp"), gameStarted: .mock(true))
    }
}
