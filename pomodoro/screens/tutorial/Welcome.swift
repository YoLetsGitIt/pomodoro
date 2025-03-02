//
//  Welcome.swift
//  pomodoro
//
//  Created by Matthew Kwon on 2/3/2025.
//

import SwiftUI

struct Welcome: View {
    
    @Binding var tutorialStep: Int
    
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.9).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Thank you for downloading pomodoro!\n\nThis is a quick guide to show how to use the app")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 16)
                Button {
                    withAnimation {
                        tutorialStep = tutorialStep + 1
                    }
                } label: {
                    PomodoroButton(buttonText: "Next", fullWidth: true)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 8)
                    
                }
                Button {
                    UserDefaults.standard.set(false, forKey: "tutorialCompleted")
                    withAnimation {
                         tutorialStep = 6
                    }
                } label: {
                    PomodoroButton(buttonText: "Skip", fullWidth: true)
                        .padding(.horizontal, 40)
                }
                Spacer()
            }
        }
    }
}
