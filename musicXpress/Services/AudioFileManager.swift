//
//  AudioFileManager.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/10/22.
//

import Foundation
import Collections
import AVKit

class AudioFileManager: ObservableObject {
    
    @Published var songs: [Song] = []
    @Published var artists: [Artist] = []
	@Published var albums: [Album] = []
	
	func audioFileInfo(url: URL) -> NSDictionary? {
		var fileID: AudioFileID? = nil
		var status:OSStatus = AudioFileOpenURL(url as CFURL, .readPermission, kAudioFileFLACType, &fileID)

		guard status == noErr else { return nil }

		var dict: CFDictionary? = nil
		var dataSize = UInt32(MemoryLayout<CFDictionary?>.size(ofValue: dict))

		guard let audioFile = fileID else { return nil }

		status = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dataSize, &dict)

		guard status == noErr else { return nil }

		AudioFileClose(audioFile)

		guard let cfDict = dict else { return nil }

		let tagsDict = NSDictionary.init(dictionary: cfDict)

		return tagsDict
	}
    
    func fetchSongs() {
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let directoryEnum = FileManager.default.enumerator(at: documentDirectory, includingPropertiesForKeys: [URLResourceKey.pathKey], options: [.skipsHiddenFiles])
            
            let filePaths = directoryEnum?.allObjects as! [URL]
            
            let mp3Files = filePaths.filter {$0.isMP3 || $0.pathExtension == "flac"}
            
            for (index, mp3) in mp3Files.enumerated() {
            
                let asset = AVAsset(url: mp3)
                let metadata = asset.metadata
                
				if mp3.isFLAC || mp3.pathExtension == "flac" {
					guard let data = audioFileInfo(url: mp3) else {
						return
					}
					let song = Song(id: index, name: data["title"] as? String, artist: data["artist"] as? String, imageCover: nil, path: mp3)
					songs.append(song)
				}
				else {
					
					var song = Song()
					song.id = index
					song.path = mp3
					
					if let artist = metadata.first(where: { $0.commonKey == .commonKeyArtist }), let value = artist.value as? String {
						song.artist = value
					}
					
					if let artist = metadata.first(where: {$0.commonKey == .commonKeyTitle }), let value = artist.value as? String {
						song.name = value
					}
					
					if let artist = metadata.first(where: {$0.commonKey == .commonKeyArtwork}), let value = artist.value as? Data {
						song.imageCover = UIImage(data: value)
					}
					
					if let album = metadata.first(where: {$0.commonKey == .commonKeyAlbumName}), let value = album.value as? String {
						song.album = value
					}
					
					
					
					songs.append(song)
				}
            }
            //get artist from songs
			let artistList: [Artist] = songs.enumerated().map { (index, item) in
				return Artist(id: index, name: item.artist, image: nil)
			}
			
			let uniqueArtist = Array(Set(artistList))
			
			artists = uniqueArtist
			
			
			let albumList: [Album] = songs.sorted(by:{$0.album?.lowercased() ?? "" < $1.album?.lowercased() ?? ""})
				.enumerated()
				.map { (index, item) in
					let artist = uniqueArtist.first(where: {$0.name == item.artist})
					let artwork = songs.first(where: {$0.artist == artist?.name})?.imageCover
					return Album(id: index, name: item.album ?? "", artist: artist!, songsCount: 0, year: 2020, songs: [], artwork: artwork)
			}
			
			let uniqueAlbum = Array(Set(albumList)).sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
			
			let albumSongs = uniqueAlbum.enumerated().map { (index, album) in
				var aux = [Song]()
				for song in songs {
					if album.name == song.album {
						aux.append(song)
					}
				}
				return Album(id: index, name: album.name, artist: album.artist, songsCount: aux.count, year: album.year, songs: aux, artwork: aux.first?.imageCover)
			}
			albums = albumSongs
            
            print("size of songs", songs.count)
        } catch {
            print("Error fetching songs files", error)
        }
    }
    
}
