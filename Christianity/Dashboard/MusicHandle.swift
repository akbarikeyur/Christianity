//
//  MusicHandle.swift
//  Meditation
//
//  Created by PC on 13/12/18.
//  Copyright © 2018 PC. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer


class MusicHandle : NSObject, AVAudioPlayerDelegate {
    
    static let shared = MusicHandle()
  
    var player : AVPlayer = AVPlayer()
    var selectedTrack : TrackModel = TrackModel.init()
    
    func prepareToPlayTrack(_ track : String) {
        
        do {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
                print("Playback OK")
                try AVAudioSession.sharedInstance().setActive(true)
                print("Session is Active")
                
            } catch {
                print(error)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        PlayMusic(track)
    }
    
    func PlayMusic(_ track : String) {
        let playerItem = AVPlayerItem(url: URL(string: "https://eu1.fastcast4u.com/proxy/afreeapo?mp=/1")!)
        //let playerItem = AVPlayerItem(url: URL(string: track)!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
        setupNowPlaying()
        setupRemoteCommandCenter()
        MPNowPlayingInfoCenter.default().playbackState = .playing
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_PLAY_PAUSE), object: nil)
        
    }
    
    func pauseMusic()
    {
        player.pause()
        MPNowPlayingInfoCenter.default().playbackState = .paused
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_PLAY_PAUSE), object: nil)
    }
    
    
    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        if selectedTrack.title == ""{
            nowPlayingInfo[MPMediaItemPropertyTitle] = "Christianity"
        }else{
            nowPlayingInfo[MPMediaItemPropertyTitle] = selectedTrack.title
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime()
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        
        if let image = UIImage(named: "login_logo") {
            let artwork = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
                return image
            })
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        AppDelegate().sharedDelegate().window!.becomeFirstResponder()
    }
    
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget {event in
           // self.PlayMusic()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget {event in
         //   self.pauseMusic()
            return .success
        }
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.skipForwardCommand.isEnabled = false
        commandCenter.skipBackwardCommand.isEnabled = false
    }
    
    func remoteControlReceived(with event: UIEvent?) {
        if let receivedEvent = event {
            if (receivedEvent.type == .remoteControl) {
                switch receivedEvent.subtype {
                case .remoteControlTogglePlayPause:
                    if player.rate == 0.0 {
                        PlayMusic(selectedTrack.link)
                    } else {
                        pauseMusic()
                    }
                    break
                case .remoteControlPlay:
                    pauseMusic()
                    break
                case .remoteControlPause:
                    PlayMusic(selectedTrack.link)
                    break
                default:
                    print("received sub type \(receivedEvent.subtype) Ignoring")
                }
            }
        }
    }
    
    
}
