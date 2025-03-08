//
//  TutorialFinished.swift
//  pomodoro
//
//  Created by Matthew Kwon on 4/3/2025.
//

import SwiftUI

struct TutorialFinished: View {
    
    @Binding var tutorialStep: Int
    
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.75).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Congratulations, you've finished the tutorial!")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.WHITE)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                    .modifier(PopoutViewModifier(duration: 0.5, on: true))
                Spacer()
            }
        }
        .onTapGesture {
            withAnimation {
                tutorialStep += 1
                UserDefaults.standard.set(true, forKey: "tutorialCompleted")
            }
        }
    }
}
