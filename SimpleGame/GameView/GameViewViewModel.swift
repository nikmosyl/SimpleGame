//
//  GameViewViewModel.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import Foundation
import Observation

@Observable
final class GameViewViewModel {
    
    var height = 0.0

    var chipPosition = 0.0
    var chipSize = 0.0
    var chipState = ChipState.ready
    var chipOnTheLeft = true
    var chipCounter = 2
    
    var obstacleSize = 0.0
    
    var timeInterval = 0.005
    
    var counter = 0
    var score = 0

    var obstaclePositions: [ObstaclePosition : Double] = [
        .firstLeft : 0.0,
        .secondLeft : Double.random(in: -200 ... -100),
        .thirdLeft : Double.random(in: -700 ... -500),
        
        .firstRight : Double.random(in: -300 ... -200),
        .secondRight : Double.random(in: -500 ... -300),
        .thirdRight : Double.random(in: -1000 ... -800)
    ]
    
    var gameOver = false
        
    private var chipTimer: Timer?
    private var obstacleTimer: Timer?
    
    func didTapped() {
        switch chipState {
        case .ready:
            chipOnTheLeft.toggle()
            chipState = .inMove
            startChipTimer()
        case .inMove:
            break
        }
    }
    
    func startObstacleTimer() {
        obstacleTimer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(updateObstacleCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func updateObstacleCounter() {
        counter += 1
        score += 1
        
        obstaclePositions.forEach { key, value in
            if value > height + obstacleSize {
                obstaclePositions[key] = Double.random(in: -1000 ... -100)
            } else {
                obstaclePositions[key, default: 0] += 1
            }
        }
        
        checkPosition()
        
        if counter > 500  {
            obstacleTimer?.invalidate()
            obstacleTimer = nil
            counter = 0
            timeInterval *= timeInterval > 0.002 ? 0.95 : 1
            startObstacleTimer()
        }
    }
    
    private func startChipTimer() {
        chipTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateChipCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func updateChipCounter() {
        if chipCounter > 0 {
            chipCounter -= 1
        } else {
            chipTimer?.invalidate()
            chipTimer = nil
            chipState = .ready
            chipCounter = 2
        }
    }
    
    private func checkPosition() {
        if chipState == .inMove { return }
        
        obstaclePositions.forEach { key, value in
                        
            if (lround(value-obstacleSize)...lround(value)).contains(lround(chipPosition)) ||
                (lround(value-obstacleSize)...lround(value)).contains(lround(chipPosition + chipSize)) {
                
                switch key {
                case .firstLeft, .secondLeft, .thirdLeft:
                    if chipOnTheLeft {
                        stopGame()
                    }
                case .firstRight, .secondRight, .thirdRight:
                    if !chipOnTheLeft {
                        stopGame()
                    }
                }
            }
        }
    }
    
    private func stopGame() {
        chipState = .inMove
        gameOver = true
        obstacleTimer?.invalidate()
        obstacleTimer = nil
    }
}

extension GameViewViewModel {
    enum ChipState {
        case ready
        case inMove
    }
}

extension GameViewViewModel {
    enum ObstaclePosition {
        case firstLeft
        case secondLeft
        case thirdLeft
        case firstRight
        case secondRight
        case thirdRight
    }
}

