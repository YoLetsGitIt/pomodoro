//
//  TutorialCancelFocus.swift
//  pomodoro
//
//  Created by Matthew Kwon on 2/3/2025.
//

import SwiftUI

struct TutorialCancelFocus: View {
    
    var body: some View {
        ZStack {
            VStack {
                Text("long hold to cancel focus")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                    .modifier(BlinkViewModifier(duration: 0.5))
                    .modifier(PopoutViewModifier(duration: 0.5, on: true))
                    
                Spacer()
            }
        }
    }
}
