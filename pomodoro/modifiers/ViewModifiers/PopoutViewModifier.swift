//
//  PopoutViewModifier.swift
//  pomodoro
//
//  Created by Matthew Kwon on 4/3/2025.
//

import SwiftUI

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
