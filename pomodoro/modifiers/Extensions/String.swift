//
//  String.swift
//  pomodoro
//
//  Created by Matthew Kwon on 4/3/2025.
//

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
