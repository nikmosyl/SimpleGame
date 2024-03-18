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
        
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: horizontal, y: vertical))
            path.addLine(to: CGPoint(x: horizontal + size, y: vertical - size/2))
            path.addLine(to: CGPoint(x: horizontal, y: vertical - size))
            path.addLine(to: CGPoint(x: horizontal, y: vertical))
        }
        .stroke(
            style: StrokeStyle(lineWidth: 3)
        )
    }
}


//#Preview {
//    ObstacleView(
//        horizontal: 80,
//        vertical: 80,
//        size: 20,
//        offset: 0,
//        move: false
//    )
//}
