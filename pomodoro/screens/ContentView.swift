//
//  ContentView.swift
//  pomodoro
//
//  Created by Matthew Kwon on 9/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    let tutorialCompleted = UserDefaults.standard.bool(forKey: "tutorialCompleted")
    @State var tutorialStep = 0
    
    @GestureState private var isDetectingLongPress = false
    
    @State private var focused = false
    @State private var stopPressing = false
    @State private var stopCounter = 0.0
    @State private var completed = false {
        didSet {
            showCongratulations = true
        }
    }
    @State private var showCongratulations = false
    @State private var showFocusTypePickerSheet = false
    
    var focusType = ["focus", "study", "exercise", "read"]
    @State private var selectedFocusTypeIndex = 0
    
    var body: some View {
        ZStack {
            Color(.BACKGROUND)
                .ignoresSafeArea()
            VStack {
                Spacer()
                if !showCongratulations {
                    TimerView(focused: $focused, completed: $completed)
                }
                if showCongratulations {
                    FocusSuccess(showCongratulations: $showCongratulations)
                }
                if (!focused) {
                    Spacer()
                }
                Spacer()
            }
            if !showCongratulations { VStack {
                if !focused {
                    Spacer()
                    Spacer()
                    Button {
                        withAnimation {
                            focused = true
                        }
                    } label: {
                        PomodoroButton(buttonText: "start focus")
                            .sensoryFeedback(.start, trigger: focused == true)
                    }
                    .padding()
                    Spacer()
                } else {
                    if completed {
                        Text("break time")
                            .padding(.bottom)
                            .foregroundStyle(.WHITE)
                    }
                    Spacer()
                    if !completed {
                        if stopPressing {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 200, height: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.GREY_2)
                                Rectangle()
                                    .frame(width: stopCounter * 100, height: 5)
                                    .foregroundColor(.WHITE)
                                    .animation(.easeInOut, value: stopCounter)
                            }
                        }
                        Text("hold to stop focus")
                            .foregroundStyle(stopPressing ? .WHITE : .GREY_2)
                            .padding(.top)
                            .font(.system(size: stopPressing ? 14 : 16))
                            .sensoryFeedback(.stop, trigger: focused == false)
                    } else {
                        Button {
                            withAnimation {
                                completed = false
                                focused = false
                            }
                        } label: {
                            PomodoroButton(buttonText: "stop break")
                        }

                    }
                }
            }
            }
        }
        .overlay {
            if !tutorialCompleted && tutorialStep < 5 {
                    ZStack {
                        VStack {
                            if (tutorialStep == 0) {
                                Welcome(tutorialStep: $tutorialStep)
                            }
                            if (tutorialStep == 1) {
                                TutorialStartFocus(tutorialStep: $tutorialStep, focused: $focused)
                            }
                            if (tutorialStep == 2) {
                               TutorialCancelFocus()
                            }
                            if (tutorialStep == 3) {
                                TutorialFinished(tutorialStep: $tutorialStep)
                            }
                        }
                    }
            }
        }
        .blur(radius: showFocusTypePickerSheet ? 20 : 0)
        .sheet(isPresented: $showFocusTypePickerSheet) {
            FocusTypePickerSheet(focusType: focusType, selectedFocusTypeIndex: $selectedFocusTypeIndex, showFocusTypePickerSheet: $showFocusTypePickerSheet)
        }
        .onLongPressGesture(minimumDuration: 5) {
            
        } onPressingChanged: { inProgress in
            if focused {
                if (inProgress) {
                    withAnimation {
                        stopPressing = true
                    }
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
                                stopCounter = 0
                            }
                            withAnimation {
                                tutorialStep = tutorialStep + 1
                                timer.invalidate() // invalidate the timer
                            }
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
