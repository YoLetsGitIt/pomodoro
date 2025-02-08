//
//  Picker.swift
//  pomodoro
//
//  Created by Matthew Kwon on 5/1/2025.
//

import SwiftUI

struct MultiPicker: View {
    
    var pickerText: String
    var selected: Bool
    var onPress: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(pickerText)
                .foregroundStyle(selected ? .BACKGROUND : .white)
                .padding()
            Spacer()
        }
        .onTapGesture(perform: onPress)
        .background(selected ? .white : .BACKGROUND)
        .clipShape(.capsule)
        .overlay(
                Capsule()
                    .stroke(.white, lineWidth: 1)
                )
    }
}

#Preview {
    
    @Previewable @State var pickerText = "focus"
    @Previewable @State var falseSelected = false
    @Previewable @State var selected = true
    
    HStack {
        MultiPicker(pickerText: pickerText, selected: falseSelected, onPress: {})
        MultiPicker(pickerText: pickerText, selected: selected, onPress: {})
    }
}
