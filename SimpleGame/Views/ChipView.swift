//
//  ChipView.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import SwiftUI

struct ChipView: View {
    
    let horizontal: Double
    let vertical: Double
    let size: Double
    let offset: Double
    let move: Bool
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: horizontal, y: vertical))
            path.addLine(to: CGPoint(x: horizontal + size, y: vertical))
            path.addLine(to: CGPoint(x: horizontal + size, y: vertical + size))
            path.addLine(to: CGPoint(x: horizontal, y: vertical + size))
            path.addLine(to: CGPoint(x: horizontal, y: vertical))
        }
        .stroke(
            style: StrokeStyle(lineWidth: 3)
        )
        .offset(x: move ? offset : 0)
        .animation(.easeOut(duration: 0.3), value: move)
    }
}

#Preview {
    ChipView(
        horizontal: 100,
        vertical: 100,
        size: 20,
        offset: 0,
        move: false
    )
    .padding()
    .frame(width: 40, height: 90)
}
