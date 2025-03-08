//
//  FocusSuccess.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/2/2025.
//

import SwiftUI

struct FocusSuccess: View {
    
    @State var showConfetti: Bool = true
    @Binding var showCongratulations: Bool
    
    var body: some View {
        ZStack {
            Color(.BACKGROUND)
                .ignoresSafeArea()
            VStack {
                Text("Horray!")
                    .foregroundStyle(.WHITE)
                Text("You've completed a focus time of x minutes!")
                    .foregroundStyle(.WHITE)
                Button {
                    withAnimation {
                        showCongratulations = false
                    }
                } label: {
                    PomodoroButton(buttonText: "Done")
                }
                
            }
            .background(.GREY_1)
            .cornerRadius(16)
        }
        .displayConfetti(isActive: $showConfetti)
    }
}

#Preview {
//    FocusSuccess()
}
