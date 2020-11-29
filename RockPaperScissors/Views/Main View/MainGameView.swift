//
//  MainGameView.swift
//  RockPaperScissors
//
//  Created by Mark Perryman on 11/27/20.
//

import SwiftUI

struct MainGameView: View {
    // Game State
    @State private var possibleChoices = [Choices.rock, Choices.paper]
    @State private var possibleChoices1 = [Choices.scissors]
    @State private var animationAmount1: CGFloat = 1
    @State private var animationAmount2 = 0.0
    @State private var totalQuestions = 10
    @State private var totalConfetti = 20
    @State private var gameScore = 0
    
    @State private var gameStarted = false
    @State private var showEndOfGameAlert = false
    @State private var buttonsEnabled = false
    @State private var animateCardView = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var wasAnwserCorrect = ""

    // Player Choices
    @State private var playerScore = 0
    @State private var playersChoice = Choices.rock
    @State private var howDidIDo = ""
    
    // Game Choices
    @State private var playerShouldWinLoseOrDraw = WinOrLoseOrDraw.win
    @State private var gamesChoiceImg = Choices.rock.rawValue
    @State private var gamesChoice = Choices.rock
    
    var delayAmounts: [Double] {
        var dAmts = [Double]()
        
        for _ in 0..<3 {
            dAmts.append(Double.random(in: 1...10))
        }
        return dAmts
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                RPSScoreView(gameScore: $gameScore, playerScore: $playerScore)
                    .foregroundColor(.white)
                                
                // Card for showing computer choice
                LinearGradient(gradient: Gradient(colors: [.white, ColorBackground(for: playerShouldWinLoseOrDraw)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        HStack {
                            if !animateCardView {
                                Image(gamesChoiceImg)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .transition(.scale)                                
                            }
                            
                            if animateCardView {
                                Spacer()

                                Text("\(wasAnwserCorrect)").font(.title2).fontWeight(.black)
                                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
                             
                                Spacer()
                            }
                        }
                        .padding()
                    )
                    .opacity(gameStarted ? 1 : 0)
                    .animation(.easeInOut(duration: 1))
                
                // Start of Rock Paper Scissors buttons
                HStack {
                    ForEach(0 ..< 2) { idx in
                        Spacer()

                        Button(action: {
                            self.playersChoice = possibleChoices[idx]
                            wasAnwserCorrect = willCheckPlayersChoice(for: playerShouldWinLoseOrDraw, on: playersChoice, on: gamesChoice)
                            self.nextQuestion(totalQuestions)
                            self.buttonsEnabled.toggle()
                            withAnimation {
                                self.animateCardView.toggle()
                            }
                        }, label: {
                            RPSButtonView(imageName: possibleChoices[idx].rawValue, delayAmount: delayAmounts[idx])
                        })
                        .buttonStyle(EnlargeButtonStyle())
                        .disabled(buttonsEnabled)
                        Spacer()
                    }
                }
                .opacity(gameStarted ? 1 : 0)
                .animation(.easeInOut(duration: 1))

                HStack {
                    ForEach(0 ..< 1) { idx in
                        Spacer()

                        Button(action: {
                            self.playersChoice = possibleChoices1[idx]
                            wasAnwserCorrect = willCheckPlayersChoice(for: playerShouldWinLoseOrDraw, on: playersChoice, on: gamesChoice)
                            self.nextQuestion(totalQuestions)
                            self.buttonsEnabled.toggle()
                            withAnimation {
                                self.animateCardView.toggle()
                            }
                        }, label: {
                            RPSButtonView(imageName: possibleChoices1[idx].rawValue, delayAmount: delayAmounts[2])
                        })
                        .buttonStyle(EnlargeButtonStyle())
                        .disabled(buttonsEnabled)

                        Spacer()
                    }
                }
                .opacity(gameStarted ? 1 : 0)
                .animation(.easeInOut(duration: 1))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: { StartGame() }, label: {
                        Image(systemName: !gameStarted ? "play.fill" : "pause")
                            .font(.title2)
                            .padding(20)
                            .background(!gameStarted ? LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .bottomTrailing, endPoint: .topLeading) : LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .bottomTrailing, endPoint: .topLeading))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: Color.white, radius: 6)
                            .overlay(
                                Circle()
                                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 2)
                            )
                    }).buttonStyle(EnlargeButtonStyle())
                }.padding().offset(x: -15, y: 0)
            } // End of VStack
            
            if showEndOfGameAlert {
                Color.black.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.4))
                    .transition(.opacity)
                
                EndOfGameScoreView(isPresented: $showEndOfGameAlert, howdYouDo: $howDidIDo, totalQuestions: $totalQuestions, playerScore: $playerScore, gameScore: $gameScore, gameStarted: $gameStarted)
                    .transition(AnyTransition.slide.combined(with: .slide))
                    .animation(.easeInOut(duration: 0.5))
                    // This is needed to get the view to slide off as well
                    .zIndex(1)
            }
        } // End of ZStack
    } // End of Body
    
    private func StartGame() {
        gameStarted.toggle()
        
        if gameStarted {
            // gameStarted == True
            // Reset the score
            playerScore = 0
            gameScore = 0
            howDidIDo = ""
            
            GetComputerChoice()
            GetWinLoseOrDraw()
        } else {
            
        }
    }
    
    private func GetComputerChoice() {
        // Initialize $gamesChoice(String)
        let choice = Int.random(in: 0...2)
        
        if choice == 0 {
            gamesChoiceImg = Choices.rock.rawValue
            gamesChoice = Choices.rock
        } else if choice == 1 {
            gamesChoiceImg = Choices.paper.rawValue
            gamesChoice = Choices.paper
        } else if choice == 2 {
            gamesChoiceImg = Choices.scissors.rawValue
            gamesChoice = Choices.scissors
        }
    }
    
    private func GetWinLoseOrDraw() {
        let wldChoice = Int.random(in: 0...2)
        
        if wldChoice == 0 {
            playerShouldWinLoseOrDraw = WinOrLoseOrDraw.win
        } else if wldChoice == 1 {
            playerShouldWinLoseOrDraw = WinOrLoseOrDraw.lose
        } else if wldChoice == 2 {
            playerShouldWinLoseOrDraw = WinOrLoseOrDraw.draw
        }

    }
    
    private func nextQuestion(_ questionCnt: Int) {
        if questionCnt > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                GetComputerChoice()
                GetWinLoseOrDraw()
                self.buttonsEnabled.toggle()
                self.animateCardView.toggle()
            })
        } else {
            self.showEndOfGameAlert = true
        }
    }
    
    private func willCheckPlayersChoice(for winLose: WinOrLoseOrDraw, on playersChoice: Choices, on appsChoice: Choices) -> String {
        var correctNotCorrect = ""

        // ROCK
        if winLose == WinOrLoseOrDraw.win && appsChoice == Choices.rock && playersChoice == Choices.paper {
            playerScore += 1 // CHECK
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.lose && appsChoice == Choices.rock && playersChoice == Choices.scissors {
            playerScore += 1
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.draw && appsChoice == Choices.rock  && playersChoice == Choices.rock {
            playerScore += 1
            correctNotCorrect = "You're Correct."

        // PAPER
        } else if winLose == WinOrLoseOrDraw.win && appsChoice == Choices.paper && playersChoice == Choices.scissors {
            playerScore += 1 // CHECK
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.lose && appsChoice == Choices.paper && playersChoice == Choices.rock {
            playerScore += 1
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.draw && appsChoice == Choices.paper  && playersChoice == Choices.paper {
            playerScore += 1
            correctNotCorrect = "You're Correct."

        // SCISSORS
        } else if winLose == WinOrLoseOrDraw.win && appsChoice == Choices.scissors && playersChoice == Choices.rock {
            playerScore += 1 // CHECK
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.lose && appsChoice == Choices.scissors && playersChoice == Choices.paper {
            playerScore += 1
            correctNotCorrect = "You're Correct."
        } else if winLose == WinOrLoseOrDraw.draw && appsChoice == Choices.scissors  && playersChoice == Choices.scissors {
            playerScore += 1
            correctNotCorrect = "You're Correct."

        // PLAYER LOSES
        } else {
            gameScore += 1
            correctNotCorrect = "'You're Not Correct."
        }

        totalQuestions -= 1
        
        if totalQuestions == 0 {
            if playerScore <= 3 {
                howDidIDo = "Angry"
            } else if playerScore <= 6 {
                howDidIDo = "Thinking"
            } else {
                howDidIDo = "ThumbsUp"
            }
        }
        
        return correctNotCorrect

    }
    
    private func endOfGameMessage(_ pointsEarned: Int) -> String {
        if pointsEarned <= 0 {
            return "You anwsered 0 questions correctly."
        }
        return "You anwsered \n\(pointsEarned) out of 10\ncorrectly.\n\nResetting Game Now"
    }
    
    private func ColorBackground(for card: WinOrLoseOrDraw) -> Color {
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

struct MainGameView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
