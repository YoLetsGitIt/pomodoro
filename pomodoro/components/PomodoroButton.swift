//
//  PomodoroButton.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/12/2024.
//

import SwiftUI

struct PomodoroButton: View {
    
    var buttonText: String
    
    var body: some View {
        VStack {
            Text(buttonText)
                .foregroundStyle(.BACKGROUND)
                .padding()
                .padding(.horizontal)
                .background(.white)
                .clipShape(.capsule)
        }
    }
}
