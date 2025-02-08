//
//  FocusTypePickerSheet.swift
//  pomodoro
//
//  Created by Matthew Kwon on 8/2/2025.
//

import SwiftUI

struct FocusTypePickerSheet: View {
    
    var focusType: [String]
    @Binding var selectedFocusTypeIndex: Int
    @Binding var showFocusTypePickerSheet: Bool
    
    var body: some View {
        ZStack {
            Color.BACKGROUND.edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            Text("Select focus type")
                .foregroundStyle(.white)
            Spacer()
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 150))
            ], spacing: 20) {
                ForEach(focusType.indices, id: \.self) { index in
                    MultiPicker(pickerText: focusType[index], selected: index == selectedFocusTypeIndex, onPress: {
                            withAnimation {
                                selectedFocusTypeIndex = index
                                showFocusTypePickerSheet.toggle()
                            }
                        })
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThickMaterial)
        }
    }
}
