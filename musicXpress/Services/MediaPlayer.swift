//
//  AudioManager.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/9/22.
//

import Foundation
import AVFoundation
import MediaPlayer

class MediaPlayerManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    
	var player  = AVAudioPlayer()
	
	@Published var currentSong: Song? = nil
	@Published var isPlaying: Bool = false
	@Published var songList: [Song] = [Song]()
	
	override init() {
		super.init()
	}
	
	func pause() {
		print("TRYING TO PAUSE")
		if player.isPlaying {
			player.pause()
			isPlaying = false
		} else {
			player.play()
			isPlaying = true
		}
	}

    
	func play(song: Song, songs: [Song]) {
        do {
			print(song)
			guard let file = song.path else {
				print("Song file not reacheable!")
				return
			}
			if (songList.isEmpty || songList.count != songs.count) && songs.count != 0 {
				songList = songs
			}
			
			player = try AVAudioPlayer(contentsOf: file)
            
            let audioSession = AVAudioSession.sharedInstance()
            
			try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
            
            player.numberOfLoops = 0
            player.volume = 1
            player.prepareToPlay()
            
			self.currentSong = song
			self.isPlaying = true
			
			player.delegate = self
			
            player.play()
			
			setupNowPlaying()
			setupRemoteTransportControls()
            
        } catch {
            print("Error qlo", error)
        }
    }
	
	
	func setupRemoteTransportControls() {
	 // Get the shared MPRemoteCommandCenter
	 let commandCenter = MPRemoteCommandCenter.shared()

	 // Add handler for Play Command
	 commandCenter.playCommand.addTarget { [unowned self] event in
		 print("Play command - is playing: \(self.player.isPlaying)")
		 if !self.player.isPlaying {
			 self.player.play()
			 return .success
		 }
		 return .commandFailed
	 }

	 // Add handler for Pause Command
	 commandCenter.pauseCommand.addTarget { [unowned self] event in
		 print("Pause command - is playing: \(self.player.isPlaying)")
		 if self.player.isPlaying {
			 self.player.pause()
			 return .success
		 }
		 return .commandFailed
	 }
		
		commandCenter.changePlaybackPositionCommand.addTarget { [unowned self] event in
			let e = event as! MPChangePlaybackPositionCommandEvent
			self.player.currentTime = e.positionTime
			return .success
		}
 }

 func setupNowPlaying() {
	 // Define Now Playing Info
	 var nowPlayingInfo = [String : Any]()
	 nowPlayingInfo[MPMediaItemPropertyTitle] = currentSong?.name
	 nowPlayingInfo[MPMediaItemPropertyArtist] = currentSong?.artist
	 nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = currentSong?.album

	 if let image = currentSong?.imageCover {
		 nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
			 return image
		 }
	 }
	 nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
	 nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
	 nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

	 // Set the metadata
	 MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
 }
	
	func updateNowPlaying(isPause: Bool) {
		// Define Now Playing Info
		var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo!

		nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
		nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPause ? 0 : 1

		// Set the metadata
		MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		isPlaying = false
		guard let currentPos = songList.firstIndex(where: {$0.id == currentSong!.id}) else {
			print("song not found")
			return
		}
		var nextPos = currentPos + 1
		if nextPos <= songList.count {
			play(song: songList[nextPos], songs: [])
		}
	}
}
