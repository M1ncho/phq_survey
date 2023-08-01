//
//  TTSManager.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/08.
//

import Foundation
import AVFoundation


class TTSManager {
    
    static let shared = TTSManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
}
