//
//  EmotionDetailView.swift
//  PulseAnimationsDemo
//
//  Created by Jeremiah Hawks on 12/16/25.
//

import SwiftUI

struct EmotionDetailView: View {
    let emotion: Emotion

    var descriptionText: String {
        switch emotion.name {
        case "Calm":
            return "Breathe slowly and find your center."
        case "Focus":
            return "Channel your attention and clarity."
        case "Anxiety":
            return "Acknowledge and release tension."
        case "Anger":
            return "Let energy flow and transform."
        case "Energy":
            return "Feel the vibrant pulse of life."
        case "Love":
            return "Connect with your heart's rhythm."
        default:
            return "Breathe and be present."
        }
    }

    var body: some View {
        VStack(spacing: 40) {
            Text(emotion.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            EmotionCircleView(emotion: emotion)

            Text(descriptionText)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EmotionDetailView(emotion: Emotion.all[0])
    }
}

