//
//  AudioPlayer.swift
//  MarketPlace
//
//  Created by Mohamad Basuony on 12/01/2023.
//

import Foundation
import AVFoundation

enum SoundOf : String {
    case Chat = "Ding"
    case Notification = "Notification"
}

class AudioPlayer {
    
    static let shared = AudioPlayer()
    
    private init(){}
    
    var player: AVAudioPlayer?

    func playSound(soundOf : SoundOf) {
        guard let url = Bundle.main.url(forResource: soundOf.rawValue, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
