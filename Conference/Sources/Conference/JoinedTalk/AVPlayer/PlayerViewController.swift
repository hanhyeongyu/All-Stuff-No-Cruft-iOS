//
//  PlayerViewController.swift
//  
//
//  Created by 한현규 on 9/6/24.
//

import SwiftUI
import AVKit

struct PlayerViewController: UIViewControllerRepresentable{

    private let player: AVPlayer
    
    init(player: AVPlayer) {
        self.player = player
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let viewController = AVPlayerViewController()
                        
        viewController.player = player
        viewController.delegate = context.coordinator
                
        viewController.showsPlaybackControls = true
        viewController.requiresLinearPlayback = false
        viewController.videoGravity = .resizeAspect
        
        //PIP
        viewController.allowsPictureInPicturePlayback = true
        viewController.canStartPictureInPictureAutomaticallyFromInline = true
        viewController.player?.allowsExternalPlayback = true

        viewController.allowsVideoFrameAnalysis = true
        viewController.setNeedsUpdateOfSupportedInterfaceOrientations()

                        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }

        
        
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    
    
    func makeCoordinator() -> Coordinate{
        Coordinate(parent: self)
    }
    
    
    class Coordinate: NSObject, AVPlayerViewControllerDelegate{
        var parent: PlayerViewController
    
        
        init(parent: PlayerViewController) {
            self.parent = parent
        }
        
        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            print("playerViewControllerWillStartPictureInPicture")
        }
        
        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            print("playerViewControllerDidStartPictureInPicture")
        }
        
        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            print("playerViewControllerWillStopPictureInPicture")
        }
        
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            print("playerViewControllerDidStopPictureInPicture")
        }
         
        
        
    }
    

}
