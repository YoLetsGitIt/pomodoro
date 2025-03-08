//
//  TutorialStartFocus.swift
//  pomodoro
//
//  Created by Matthew Kwon on 2/3/2025.
//

import SwiftUI

struct TutorialStartFocus: View {
    
    @Binding var tutorialStep: Int
    @Binding var focused: Bool
    
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.75).ignoresSafeArea()
            VStack {
                Text("This is the button to start your pomodoro timer")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.WHITE)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                    .modifier(PopoutViewModifier(duration: 0.5, on: true))
                Spacer()
            }
            .padding(.top)
            VStack {
                Spacer()
                Spacer()
                Button {
                    withAnimation {
                        tutorialStep = tutorialStep + 1
                        withAnimation {
                            focused = true
                        }
                    }
                } label: {
                    PomodoroButton(buttonText: "start focus", blinkingAnimation: true)
                        .modifier(BlinkViewModifier(duration: 0.5))
                        .sensoryFeedback(.start, trigger: focused == true)
                }
                Spacer()
            }
        }
    }
}
