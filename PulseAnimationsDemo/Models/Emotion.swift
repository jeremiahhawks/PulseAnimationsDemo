//
//  Emotion.swift
//  PulseAnimationsDemo
//
//  Created by Jeremiah Hawks on 12/16/25.
//

import SwiftUI

struct Emotion: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let animationDuration: Double
    let animationCurve: Animation

    static let all: [Emotion] = [
        Emotion(
            name: "Calm",
            color: .blue,
            animationDuration: 4.0,
            animationCurve: .easeInOut(duration: 4.0)
        ),
        Emotion(
            name: "Focus",
            color: .purple,
            animationDuration: 3.0,
            animationCurve: .easeInOut(duration: 3.0)
        ),
        Emotion(
            name: "Anxiety",
            color: .orange,
            animationDuration: 1.0,
            animationCurve: .linear(duration: 1.0)
        ),
        Emotion(
            name: "Anger",
            color: .red,
            animationDuration: 0.8,
            animationCurve: .easeIn(duration: 0.8)
        ),
        Emotion(
            name: "Energy",
            color: .yellow,
            animationDuration: 1.5,
            animationCurve: .linear(duration: 1.5)
        ),
        Emotion(
            name: "Love",
            color: .pink,
            animationDuration: 1.2,
            animationCurve: .easeInOut(duration: 1.2)
        )
    ]
}

