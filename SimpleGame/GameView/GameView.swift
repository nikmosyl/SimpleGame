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
            let figureSize = min(width, height) / 10
            
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
                    size: figureSize,
                    offset: trailingBorder - leadingBorder - figureSize,
                    move: !gameViewVM.chipOnTheLeft
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.firstLeft] ?? 0,
                    size: figureSize * 0.75
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.secondLeft] ?? 0,
                    size: figureSize * 0.75
                )
                
                ObstacleView(
                    horizontal: leadingBorder,
                    vertical: gameViewVM.obstaclePositions[.thirdLeft] ?? 0,
                    size: figureSize * 0.75
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.firstRight] ?? 0,
                    size: -figureSize * 0.75
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.secondRight] ?? 0,
                    size: -figureSize * 0.75
                )
                
                ObstacleView(
                    horizontal: trailingBorder,
                    vertical: gameViewVM.obstaclePositions[.thirdRight] ?? 0,
                    size: -figureSize * 0.75
                )
                
                
            }
            .onAppear {
                gameViewVM.chipPosition = height * 0.8
                gameViewVM.obstacleSize = figureSize
                gameViewVM.startObstacleTimer()
            }
        }
        .alert("GAME OVER", isPresented: $gameViewVM.gameOver, actions: {
            Button(action: { gameOn = false }) {
                Text("RESTART")
            }
        }, message: {
            Text("your score \(gameViewVM.score)")
        })
    }
}

#Preview {
    GameView(gameOn: .constant(false))
        .ignoresSafeArea()
}
