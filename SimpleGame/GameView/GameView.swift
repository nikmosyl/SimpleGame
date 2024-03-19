//
//  GameView.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import SwiftUI

struct GameView: View {
    @Binding var gameOn: Bool
    @State private var chipMove = false
    
    @State var gameViewVM = GameViewViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let width = Double(geometry.size.width)
            let height = Double(geometry.size.height)
            let leadingBorder = width * 0.1
            let trailingBorder = width * 0.9
            let chipSize = min(width, height) / 10
            let obstacleSize = chipSize * 0.75
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.background)
                    .onTapGesture {
                        gameViewVM.didTapped()
                    }
                
                VerticalLineView(leading: leadingBorder)
                
                VerticalLineView(leading: trailingBorder)
                
                ChipView(
                    horizontal: leadingBorder,
                    vertical: height * 0.8,
                    size: chipSize,
                    offset: trailingBorder - leadingBorder - chipSize,
                    move: !gameViewVM.chipOnTheLeft
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.firstLeft] ?? 0,
                    size: obstacleSize,
                    flank: true
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.secondLeft] ?? 0,
                    size: obstacleSize,
                    flank: true
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.thirdLeft] ?? 0,
                    size: obstacleSize,
                    flank: true
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.firstRight] ?? 0,
                    size: obstacleSize,
                    flank: false
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.secondRight] ?? 0,
                    size: obstacleSize,
                    flank: false
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.thirdRight] ?? 0,
                    size: obstacleSize,
                    flank: false
                )
                
                if gameViewVM.gameOver {
                    VStack(spacing: 50) {
                        Text("GAME OVER")
                            .font(.title)
                        
                        Text("Your score: \(gameViewVM.score)")
                            .bold()
                        
                        if gameViewVM.score < 1000 {
                            Text("Tap the screen to make a move")
                        }
                        
                        Button(action: { gameOn = false }) {
                            Text("RESTART")
                                .font(.title)
                                .foregroundStyle(.background)
                                .colorInvert()
                        }
                        .frame(width: trailingBorder - leadingBorder * 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 3)
                        )
                    }
                }
            }
            .onAppear {
                gameViewVM.height = height
                gameViewVM.chipPosition = height * 0.8
                gameViewVM.chipSize = chipSize
                gameViewVM.obstacleSize = obstacleSize
                gameViewVM.startObstacleTimer()
            }
        }
    }
}

#Preview {
    GameView(gameOn: .constant(false))
        .ignoresSafeArea()
}
