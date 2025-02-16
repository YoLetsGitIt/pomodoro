//
//  ContentView.swift
//  pomodoro
//
//  Created by Matthew Kwon on 9/11/2024.
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

struct ContentView: View {
    
    let tutorialCompleted = UserDefaults.standard.bool(forKey: "tutorialCompleted")
    @State var tutorialStep = 0
    
    @GestureState private var isDetectingLongPress = false
    
    @State private var focused = false
    @State private var stopPressing = false
    @State private var stopCounter = 0.0
    @State private var completed = false
    @State private var showFocusTypePickerSheet = false
    
    var focusType = ["focus", "study", "exercise", "read"]
    @State private var selectedFocusTypeIndex = 0
    
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
                TimerView(focused: $focused, completed: $completed)
                if !focused {
                    Button {
                        withAnimation {
                            showFocusTypePickerSheet.toggle()
                        }
                } label: {
                    Text(focusType[selectedFocusTypeIndex] + " >")
                        .foregroundColor(.white)
                }
                }
                if (!focused) {
                    Spacer()
                }
                Spacer()
            }
            VStack {
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
                            .font(.system(size: stopPressing ? 14 : 16))
                            .sensoryFeedback(.stop, trigger: focused == false)
                    } else {
                        Button {
                            withAnimation {
                                completed = false
                                focused = false
                            }
                        } label: {
                            PomodoroButton(buttonText: "end break")
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
                                ZStack {
                                    Color(white: 0, opacity: 0.9).ignoresSafeArea()
                                    VStack {
                                        Spacer()
                                        Text("Thank you for downloading pomodoro!\n\nThis is a quick guide to show how to use the app")
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(15)
                                            .padding(.horizontal, 40)
                                            .padding(.bottom, 16)
                                        Button {
                                            withAnimation {
                                                tutorialStep = tutorialStep + 1
                                            }
                                        } label: {
                                            PomodoroButton(buttonText: "Next", fullWidth: true)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom, 8)
                                            
                                        }
                                        Button {
                                            UserDefaults.standard.set(false, forKey: "tutorialCompleted")
                                            withAnimation {
                                                 tutorialStep = 6
                                            }
                                        } label: {
                                            PomodoroButton(buttonText: "Skip", fullWidth: true)
                                                .padding(.horizontal, 40)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            if (tutorialStep == 1) {
                                ZStack {
                                    Color(white: 0, opacity: 0.75).ignoresSafeArea()
                                    VStack {
                                        Spacer()
                                        Text("This is the button to start your pomodoro timer")
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(15)
                                            .padding(.horizontal, 40)
                                        Spacer()
                                    }
                                    VStack {
                                        Spacer()
                                        Spacer()
                                        Button {
                                            withAnimation {
                                                tutorialStep = tutorialStep + 1
                                                withAnimation {
                                                    focused = true
                                                }
                                            }
                                        } label: {
                                            PomodoroButton(buttonText: "start focus", blinkingAnimation: true)
                                                .modifier(BlinkViewModifier(duration: 0.5))
                                                .sensoryFeedback(.start, trigger: focused == true)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            if (tutorialStep == 2) {
                                ZStack {
                                    VStack {
                                        Text("long hold to cancel focus")
                                            .multilineTextAlignment(.center)
                                            .modifier(PopoutViewModifier(duration: 0.5, on: true))
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(15)
                                            .padding(.horizontal, 40)
                                            .padding(.top, 40)
                                            .modifier(BlinkViewModifier(duration: 0.5))
                                            
                                        Spacer()
                                    }
                                }
                            }
                            if (tutorialStep == 3) {
                                
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
                            tutorialStep = tutorialStep + 1
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
