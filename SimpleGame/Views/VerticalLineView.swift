//
//  VerticalLineVuew.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import SwiftUI

struct VerticalLineView: View {
    let leading: Double
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: leading, y: 0))
                path.addLine(to: CGPoint(x: leading, y: geometry.size.height))
            }
            .stroke(style: StrokeStyle(lineWidth: 3))
        }
    }
}

#Preview {
    VerticalLineView(leading: 80)
}
