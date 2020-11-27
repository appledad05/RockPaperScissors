//
//  RPSButtonView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI

struct RPSButtonView: View {
    var imageName: String
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .frame(width: 75, height: 75)
            .padding(5)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading))
            .clipShape(Circle())
            .shadow(color: Color.white, radius: 6)
            .overlay(
                Circle()
                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 2)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: false)
                    )
            )
            .onAppear {
                self.animationAmount = 2
            }
    }
}

struct RPSButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RPSButtonView(imageName: "Rock")
    }
}

struct EnlargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
            .animation(.easeInOut(duration: 1))
    }
}
