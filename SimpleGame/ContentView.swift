//
//  ContentView.swift
//  SimpleGame
//
//  Created by nikita on 18.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var gameOn = false
    
    var body: some View {
        if !gameOn {
            Button(action: {gameOn.toggle()}) {
                Text("START")
                    .font(.title)
                    .foregroundStyle(.background)
                    .colorInvert()
            }
            .frame(width: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 4)
            )
        } else {
            GameView(gameOn: $gameOn)
                .ignoresSafeArea()
                .statusBarHidden()
        }
    }
}

#Preview {
    ContentView()
}
