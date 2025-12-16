//
//  EmotionCircleView.swift
//  PulseAnimationsDemo
//
//  Created by Jeremiah Hawks on 12/16/25.
//

import SwiftUI

struct EmotionCircleView: View {
    let emotion: Emotion
    @State private var scale: CGFloat = 0.9
    @State private var timer: Timer?

    // Anxiety-specific state
    @State private var anxietyColorProgress: CGFloat = 0.0 // 0.0 = orange, 1.0 = blue
    @State private var anxietySpeedProgress: CGFloat = 0.0 // 0.0 = fast (0.075), 1.0 = 75% of Love (0.2)
    @State private var anxietyMorphTimer: Timer?

    private var displayColor: Color {
        if emotion.name == "Anger" {
            // Interpolate between red (0.9 scale) and hot burnt orange (1.2 scale)
            let minScale: CGFloat = 0.9
            let maxScale: CGFloat = 1.2
            let normalizedScale = (scale - minScale) / (maxScale - minScale)

            // Red: (1.0, 0.0, 0.0) -> Hot burnt orange: (1.0, 0.4, 0.0)
            let red: CGFloat = 1.0
            let green: CGFloat = normalizedScale * 0.4
            let blue: CGFloat = 0.0

            return Color(red: red, green: green, blue: blue)
        } else if emotion.name == "Anxiety" {
            // Interpolate between orange and calming blue
            // Orange: (1.0, 0.647, 0.0) -> Blue: (0.0, 0.478, 1.0)
            let orangeRed: CGFloat = 1.0
            let orangeGreen: CGFloat = 0.647
            let orangeBlue: CGFloat = 0.0

            let blueRed: CGFloat = 0.0
            let blueGreen: CGFloat = 0.478
            let blueBlue: CGFloat = 1.0

            let red = orangeRed + (blueRed - orangeRed) * anxietyColorProgress
            let green = orangeGreen + (blueGreen - orangeGreen) * anxietyColorProgress
            let blue = orangeBlue + (blueBlue - orangeBlue) * anxietyColorProgress

            return Color(red: red, green: green, blue: blue)
        } else {
            return emotion.color
        }
    }

    var body: some View {
        Circle()
            .stroke(displayColor, lineWidth: 64)
            .frame(width: 200, height: 200)
            .scaleEffect(scale)
            .onAppear {
                if emotion.name == "Love" {
                    startHeartbeatAnimation()
                } else if emotion.name == "Anxiety" {
                    startAnxietyAnimation()
                } else {
                    startRegularAnimation()
                }
            }
            .onDisappear {
                timer?.invalidate()
                anxietyMorphTimer?.invalidate()
            }
    }

    private func startRegularAnimation() {
        withAnimation(emotion.animationCurve.repeatForever(autoreverses: true)) {
            scale = 1.2
        }
    }

    private func startHeartbeatAnimation() {
        var step = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
            step += 1

            switch step {
            case 1: // First pulse up
                withAnimation(.easeInOut(duration: 0.15)) {
                    scale = 1.15
                }
            case 2: // First pulse down
                withAnimation(.easeInOut(duration: 0.15)) {
                    scale = 0.9
                }
            case 3, 4: // Short pause (do nothing)
                break
            case 5: // Second pulse up
                withAnimation(.easeInOut(duration: 0.15)) {
                    scale = 1.15
                }
            case 6: // Second pulse down
                withAnimation(.easeInOut(duration: 0.15)) {
                    scale = 0.9
                }
            case 7, 8, 9, 10: // Longer pause (do nothing)
                break
            default:
                step = 0 // Reset to start of cycle
            }
        }
    }

    private func startAnxietyAnimation() {
        // Start the morphing timer that gradually changes color and speed over 20 seconds
        let morphDuration: TimeInterval = 20.0
        let updateInterval: TimeInterval = 0.1 // Update every 0.1 seconds for smooth transition
        let totalSteps = Int(morphDuration / updateInterval)

        var currentStep = 0
        anxietyMorphTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [self] _ in
            currentStep += 1
            let progress = min(CGFloat(currentStep) / CGFloat(totalSteps), 1.0)

            withAnimation(.linear(duration: updateInterval)) {
                anxietyColorProgress = progress
                anxietySpeedProgress = progress
            }

            if currentStep >= totalSteps {
                anxietyMorphTimer?.invalidate()
            }
        }

        // Start the heartbeat animation with dynamic speed
        startAnxietyHeartbeat()
    }

    private func startAnxietyHeartbeat() {
        // Calculate current speed based on progress
        // Start: 0.075 seconds, End: 0.2 seconds (75% of Love's 0.15 / 0.75 = 0.2)
        let minSpeed: CGFloat = 0.075
        let maxSpeed: CGFloat = 0.2
        let currentSpeed = minSpeed + (maxSpeed - minSpeed) * anxietySpeedProgress

        var step = 0
        timer?.invalidate() // Invalidate previous timer if exists

        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(currentSpeed), repeats: true) { [self] _ in
            // Recalculate speed in case it changed
            let currentSpeed = minSpeed + (maxSpeed - minSpeed) * anxietySpeedProgress

            step += 1

            switch step {
            case 1: // First pulse up
                withAnimation(.easeInOut(duration: TimeInterval(currentSpeed))) {
                    scale = 1.15
                }
            case 2: // First pulse down
                withAnimation(.easeInOut(duration: TimeInterval(currentSpeed))) {
                    scale = 0.9
                }
            case 3, 4: // Short pause (do nothing)
                break
            case 5: // Second pulse up
                withAnimation(.easeInOut(duration: TimeInterval(currentSpeed))) {
                    scale = 1.15
                }
            case 6: // Second pulse down
                withAnimation(.easeInOut(duration: TimeInterval(currentSpeed))) {
                    scale = 0.9
                }
            case 7, 8, 9, 10: // Longer pause (do nothing)
                break
            default:
                step = 0 // Reset to start of cycle
                // Recreate timer every 2 cycles to pick up speed changes
                timer?.invalidate()
                startAnxietyHeartbeat()
            }
        }
    }
}

