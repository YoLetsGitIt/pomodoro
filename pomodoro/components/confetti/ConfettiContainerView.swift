//
//  ConfettiContainerView.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/3/2025.
//
// imported from https://medium.com/@jaredcassoutt/swiftui-tutorials-designing-a-dynamic-confetti-effect-aa531c5adfb1

// the animation works because the position property is automatically animated when its changed

import SwiftUI

struct ConfettiContainerView: View {
    var count: Int = 50
    @State var yPosition: CGFloat = 0

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { _ in
                ConfettiView()
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: yPosition != 0 ? CGFloat.random(in: 0...UIScreen.main.bounds.height) : yPosition
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            yPosition = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

#Preview {
    ConfettiContainerView()
}
