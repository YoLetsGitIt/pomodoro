//
//  PomodoroButton.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/12/2024.
//

import SwiftUI

struct CustomFrameModifier : ViewModifier {
    var fullWidth : Bool
    
    @ViewBuilder func body(content: Content) -> some View {
        if fullWidth {
            content.frame(maxWidth: .infinity)
        } else {
            content
        }
    }
}

struct PopoutViewModifier: ViewModifier {
    
    let duration: Double
    let on: Bool
    @State var blinking: Bool = false
    
    func body(content: Content) -> some View {
        if (on) {
            content
                .padding(blinking ? 0 : 4)
                .animation(.easeOut(duration: duration).repeatForever(), value: blinking)
                .onAppear {
                    withAnimation {
                        blinking = true
                    }
                }
        } else {
            content
        }
       
    }
}

struct PomodoroButton: View {
    
    var buttonText: String
    var fullWidth: Bool = false
    var blinkingAnimation: Bool = false
    
    var body: some View {
        VStack {
            Text(buttonText)
                .foregroundStyle(.BACKGROUND)
                .padding()
                .padding(.horizontal)
                .modifier(PopoutViewModifier(duration: 0.5, on: blinkingAnimation))
                .modifier(CustomFrameModifier(fullWidth: fullWidth))
                .background(.white)
                .clipShape(.capsule)
        }
    }
}
