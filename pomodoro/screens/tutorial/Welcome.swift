//
//  Welcome.swift
//  pomodoro
//
//  Created by Matthew Kwon on 2/3/2025.
//

import SwiftUI

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

struct Welcome: View {
    
    let finalText: String = "p o m o d o r o"
    
    @Binding var tutorialStep: Int
    @State var text: String = ""
    @State var showButtons: Bool = false
    
    func typeWriter(at position: Int = 0) {
      if position < finalText.count {
        // Run the code inside the DispatchQueue after 0.2s
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                text.append(finalText[position])
                typeWriter(at: position + 1)
        }
      }
    }
    
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.95).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Welcome to")
                    .foregroundStyle(.white)
                    .font(.custom("RedditMono-Bold", size: 24))
                    .bold()
                    .multilineTextAlignment(.center)
                    .monospacedDigit()
                    .padding(.bottom)
                Text(text)
                    .foregroundStyle(.white)
                    .font(.custom("RedditMono-Bold", size: 32))
                    .bold()
                    .multilineTextAlignment(.center)
                    .monospacedDigit()
                    .padding(.bottom)
                    .padding(.bottom)
                Spacer()
                VStack {
                    Button {
                        withAnimation {
                            tutorialStep += 1
                        }
                    } label: {
                        PomodoroButton(buttonText: "Start tutorial", fullWidth: true)
                            .padding(.horizontal, 40)
                    }
                    .padding(.bottom)
                    Button {
                        UserDefaults.standard.set(false, forKey: "tutorialCompleted")
                        withAnimation {
                            tutorialStep = 6
                        }
                    } label: {
                        PomodoroButton(buttonText: "Skip", type: "secondary", fullWidth: true)
                            .padding(.horizontal, 40)
                    }
                }
                .opacity(showButtons ? 1 : 0)
                .onChange(of: text) {
                    if (text == finalText) {
                        withAnimation {
                            showButtons = true
                        }
                    }
                }
            }
        }
        .onAppear(perform: {typeWriter()})
    }
}
