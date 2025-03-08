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

struct PomodoroButton: View {
    
    var buttonText: String
    var type: String = "main"
    var fullWidth: Bool = false
    var blinkingAnimation: Bool = false
    
    var body: some View {
        VStack {
            Text(buttonText)
                .foregroundStyle(type == "main" ? .BACKGROUND : .WHITE)
                .padding()
                .padding(.horizontal)
                .modifier(PopoutViewModifier(duration: 0.5, on: blinkingAnimation))
                .modifier(CustomFrameModifier(fullWidth: fullWidth))
                .background(type == "main" ? .WHITE : .BACKGROUND)
                .clipShape(.capsule)
        }
    }
}
