//
//  MainView.swift
//  PulseAnimationsDemo
//
//  Created by Jeremiah Hawks on 12/16/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = EmotionListViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Pulse")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Select an emotional state")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)

                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(viewModel.emotions) { emotion in
                        NavigationLink(destination: EmotionDetailView(emotion: emotion)) {
                            VStack(spacing: 12) {
                                Circle()
                                    .stroke(emotion.color, lineWidth: 32)
                                    .frame(width: 80, height: 80)

                                Text(emotion.name)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 40)

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}

