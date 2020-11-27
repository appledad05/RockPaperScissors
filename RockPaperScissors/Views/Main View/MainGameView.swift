//
//  MainGameView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI
import CoreML

struct MainGameView: View {
    @State private var possibleChoices = [Choices.rock, Choices.paper, Choices.scissors]
    
    var rpsModel: RPS {
        do {
            let config = MLModelConfiguration()
            return try RPS(configuration: config)
        } catch {
            fatalError("Couldn't create rock paper scissors choice")
        }
    }
    
    var winLoseModel: WinLose {
        do {
            let config = MLModelConfiguration()
            return try WinLose(configuration: config)
        } catch {
            fatalError("Couldn't create win/lose choice")
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                RPSScoreView(gameScore: .mock(10), playerScore: .mock(10))
                    .foregroundColor(.white)
                
                GameChoiceView(imageName: .mock("Rock"), winLoseOrDraw: .mock(.draw), result: .mock("Won"))
                
                ForEach(0 ..< 3) { idx in
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        RPSButtonView(imageName: possibleChoices[idx].rawValue)
                    })
                    .buttonStyle(EnlargeButtonStyle())
                }
                
                Spacer()
            }
        }
    }
}

struct MainGameView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
