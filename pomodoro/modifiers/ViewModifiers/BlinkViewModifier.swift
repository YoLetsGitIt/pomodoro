//
//  BlinkViewModifier.swift
//  pomodoro
//
//  Created by Matthew Kwon on 2/3/2025.
//

import SwiftUI

struct BlinkViewModifier: ViewModifier {
    
    let duration: Double
    @State var blinking: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.75 : 1)
            .animation(.easeOut(duration: duration).repeatForever(), value: blinking)
            .onAppear {
                withAnimation {
                    blinking = true
                }
            }
    }
}
