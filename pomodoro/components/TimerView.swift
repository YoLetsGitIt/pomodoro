//
//  Timer.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/12/2024.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var pomodoroTime: Int
    @Binding var timeRemaining: Int
    @Binding var focused: Bool
    
    public func msFrom() -> (Int, Int) {
        return ((timeRemaining % 3600) / 60, (timeRemaining % 3600) % 60)
    }
    
    private func getMinute(minute: Int) -> String {
           if (minute == 0) {
               return "00:"
           }

           if (minute < 10) {
               return "0\(minute):"
           }

           return "\(minute):"
       }
    
    private func getSecond(second: Int) -> String {
           if (second == 0){
               return "00"
           }

           if (second < 10) {
               return "0\(second)"
           }
           return "\(second)"
       }
    
    public func convertDurationToString() -> String {
        let (minute, second) = msFrom()
        return "\(getMinute(minute: minute))\(getSecond(second: second))"
    }
    
    var body: some View {
        ZStack {
            if focused {
                Circle()
                    .stroke(
                        .SECONDARY,
                        lineWidth: 15
                    )
            }
            if focused {
                Circle()
                    .trim(from: 0, to: CGFloat((Float(pomodoroTime) - Float(timeRemaining)) / Float(pomodoroTime)))
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                // 1
                    .animation(.easeOut, value: CGFloat((Float(pomodoroTime) - Float(timeRemaining)) / Float(pomodoroTime)))
            }
            Text("\(convertDurationToString())")
                .foregroundStyle(.white)
                .font(.custom(
                            "Helvetica",
                            size: focused ? 64 : 96,
                            relativeTo: .largeTitle))
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    
    @Previewable @State var pomodoroTime = 20
    @Previewable @State var timeRemaining = 20
    @Previewable @State var focused = false
    
    TimerView(pomodoroTime: $pomodoroTime, timeRemaining: $timeRemaining, focused: $focused)
}
