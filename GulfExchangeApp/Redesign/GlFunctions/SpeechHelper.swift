import AVFoundation

class SpeechHelper {
    static let shared = SpeechHelper()
    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func speak(_ text: String, languageCode: String) {
//        guard UserDefaults.standard.bool(forKey: "isSpeechEnabled") else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5 // Adjust speed (0.5 is natural, 1.0 is fast)
        utterance.pitchMultiplier = 1.0 // Adjust pitch (1.0 is default)

        // Map language codes to iOS-supported voices
        let languageMapping: [String: String] = [
            "en": "en-US", "ar": "ar-SA", "hi": "hi-IN", "ml": "ml-IN",
            "ta": "ta-IN", "bn": "bn-IN", "ne": "ne-NP", "tr": "tr-TR",
            "sw": "sw-KE", "si": "si-LK", "tl": "fil-PH", "ur": "ur-PK",
            "fr": "fr-FR", "id": "id-ID"
        ]

        if let voice = AVSpeechSynthesisVoice(language: languageMapping[languageCode] ?? "en-US") {
            utterance.voice = voice
            synthesizer.speak(utterance)
        } else {
            print("Voice for \(languageCode) not available")
        }
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
