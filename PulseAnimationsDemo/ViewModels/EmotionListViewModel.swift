//
//  EmotionListViewModel.swift
//  PulseAnimationsDemo
//
//  Created by Jeremiah Hawks on 12/16/25.
//

import Foundation

class EmotionListViewModel: ObservableObject {
    @Published var emotions: [Emotion] = Emotion.all
}

