//
//  GameChoiceView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI

struct GameChoiceView: View {
    @Binding var imageName: String
    @Binding var winLoseOrDraw: WinOrLose
    @Binding var result: String
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, ColorBackground(for: winLoseOrDraw)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                HStack {
                    Image(imageName)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    Text("You \(result)").font(.largeTitle).fontWeight(.black)
                    
                    Spacer()
                }
                .padding()
            )
    }
    
    private func ColorBackground(for card: WinOrLose) -> Color {
        switch card {
        case .win:
            return .green
        case .lose:
            return .red
        case .draw:
            return .blue
        }
    }
}

struct GameChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GameChoiceView(imageName: .mock("Rock"), winLoseOrDraw: .mock(.lose), result: .mock("Won"))
    }
}
