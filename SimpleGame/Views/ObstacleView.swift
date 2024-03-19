//
//  ObstacleView.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import SwiftUI

struct ObstacleView: View {
    let horizontal: Double
    let vertical: Double
    let size: Double
    let flank: Bool
        
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: horizontal, y: vertical))
            path.addLine(
                to: CGPoint(
                    x: horizontal + (flank ? size : -size),
                    y: vertical - size/2
                )
            )
            path.addLine(to: CGPoint(x: horizontal, y: vertical - size))
            path.addLine(to: CGPoint(x: horizontal, y: vertical))
        }
        .stroke(
            style: StrokeStyle(lineWidth: 3)
        )
    }
}


#Preview {
    VStack {
        ObstacleView(
            horizontal: 100,
            vertical: 100,
            size: 40,
            flank: true
        )
        
        ObstacleView(
            horizontal: 200,
            vertical: 200,
            size: 50,
            flank: false
        )
    }

}
