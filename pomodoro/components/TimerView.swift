//
//  Timer.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/12/2024.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var focused: Bool
    @Binding var completed: Bool
    
    @State var focusTime: Int = 1500
    @State private var breakTime = 300
    @State var timeRemaining: Int
    
    init(focused: Binding<Bool>, completed: Binding<Bool>) {
        self._focused = focused
        self._completed = completed
        self.timeRemaining = completed.wrappedValue ? 300 : 1500
    }
    
    let pomodoroTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let breakTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                        .GREY_2,
                        lineWidth: 15
                    )
            }
            if focused {
                Circle()
                    .trim(from: 0, to: CGFloat((Float(completed ? breakTime : focusTime) - Float(timeRemaining)) / Float(completed ? breakTime : focusTime)))
                    .stroke(
                        .WHITE,
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                // 1
                    .animation(.easeOut, value: CGFloat((Float(completed ? breakTime : focusTime) - Float(timeRemaining)) / Float(completed ? breakTime : focusTime)))
            }
            Text("\(convertDurationToString())")
                .foregroundStyle(.WHITE)
                .font(.custom(
                            "Helvetica",
                            size: focused ? 64 : 96,
                            relativeTo: .largeTitle))
        }
        .padding(.horizontal, 32)
        .onChange(of: focused) {
            if !focused {
                timeRemaining = focusTime
            }
        }
        .onReceive(pomodoroTimer) { time in
            guard focused else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // pomodoro completed logic
                withAnimation {
                    completed = true
                    timeRemaining = breakTime
                }
            }
        }
        .onReceive(breakTimer) { time in
            guard completed else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                withAnimation {
                    completed = false
                    focused = false
                    timeRemaining = focusTime
                }
            }
        }
    }
}

#Preview {
    
    @Previewable @State var focused = false
    @Previewable @State var completed = false
    
    VStack {
        TimerView(focused: $focused, completed: $completed)
    }.background(Color.BACKGROUND)
}
