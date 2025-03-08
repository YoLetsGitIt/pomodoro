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
            HStack {
                Spacer()
                VStack {
                    Text("Horray!")
                        .foregroundStyle(.WHITE)
                        .font(.custom("RedditMono-Bold", size: 20))
                    Text("You've completed a pomodoro cycle!")
                        .foregroundStyle(.WHITE)
                        .font(.custom("RedditMono-Bold", size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                    Button {
                        withAnimation {
                            showCongratulations = false
                        }
                    } label: {
                        PomodoroButton(buttonText: "Done")
                    }
                    
                }
                .padding()
                .background(.GREY_1)
                .cornerRadius(16)
                Spacer()
            }
        }
        .displayConfetti(isActive: $showConfetti)
    }
}

#Preview {
    
    @Previewable @State var showCongratulations: Bool = true
    
    FocusSuccess(showCongratulations: $showCongratulations)
}
