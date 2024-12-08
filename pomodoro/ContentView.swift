//
//  ContentView.swift
//  pomodoro
//
//  Created by Matthew Kwon on 9/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @GestureState private var isDetectingLongPress = false
    
    @State private var pomodoroTime = 1500
    @State private var timeRemaining = 1500
    @State private var breakTime = 300
    @State private var breakTimeRemaining = 300
    @State private var focused = false
    @State private var stopPressing = false
    @State private var stopCounter = 0.0
    @State private var completed = false
    let pomodoroTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let breakTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(.BACKGROUND)
                .ignoresSafeArea()
            VStack {
                Spacer()
                if completed {
                    Text("break time")
                        .padding(.bottom)
                        .foregroundStyle(.white)
                }
                TimerView(pomodoroTime: !completed ? $pomodoroTime : $breakTime, timeRemaining: !completed ? $timeRemaining : $breakTimeRemaining, focused: $focused)
                
                if (!focused) {
                    Spacer()
                }
                Spacer()
            }
            VStack {
                if !focused {
                    Spacer()
                    Button {
                        withAnimation {
                            focused = true
                        }
                    } label: {
                        PomodoroButton(buttonText: "start focus")
                    }
                    .padding()
                } else {
                    Spacer()
                    if !completed {
                        if stopPressing {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 200, height: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.SECONDARY)
                                Rectangle()
                                    .frame(width: stopCounter * 100, height: 5)
                                    .foregroundColor(.white)
                                    .animation(.easeInOut, value: stopCounter)
                            }
                        }
                        Text("hold to stop focus")
                            .foregroundStyle(stopPressing ? .white : .SECONDARY)
                            .padding(.top)
                    } else {
                        Button {
                            withAnimation {
                                completed = false
                                focused = false
                                timeRemaining = pomodoroTime
                                breakTimeRemaining = breakTime
                            }
                        } label: {
                            PomodoroButton(buttonText: "end break")
                        }
                    }
                }
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
                }
            }
        }
        .onReceive(breakTimer) { time in
            guard completed else { return }
            if breakTimeRemaining > 0 {
                breakTimeRemaining -= 1
            } else {
                withAnimation {
                    completed = false
                    focused = false
                    timeRemaining = pomodoroTime
                    breakTimeRemaining = breakTime
                }
            }
        }
        .onLongPressGesture(minimumDuration: 5) {
            
        } onPressingChanged: { inProgress in
            if focused {
                if (inProgress) {
                    stopPressing = true
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        if !stopPressing  {
                            timer.invalidate()
                            return
                        }
                        // check for max execution count of timer.
                        if stopCounter > 2 {
                            withAnimation {
                                focused = false
                                stopPressing = false
                                timeRemaining = pomodoroTime
                                stopCounter = 0
                            }
                            timer.invalidate() // invalidate the timer
                        } else {
                            withAnimation {
                                stopCounter += 0.1
                            }
                        }
                    }
                } else {
                    stopCounter = 0.0
                    withAnimation {
                        stopPressing = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
