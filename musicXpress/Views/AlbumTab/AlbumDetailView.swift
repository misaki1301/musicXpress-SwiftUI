//
//  AlbumDetailView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 5/11/22.
//

import SwiftUI

struct AlbumDetailView: View {
	
	@EnvironmentObject var mediaPlayer: MediaPlayerManager
	
	var album: Album
	
    var body: some View {
		VStack {
			HStack(alignment: .top) {
				if album.artwork == nil {
					Image("escape_cover")
						.resizable()
						.frame(maxWidth: .infinity)
				} else {
					Image(uiImage: album.artwork!)
						.resizable()
						.frame(maxWidth: .infinity)
				}
				VStack(alignment: .leading) {
					Text(album.name)
						.font(.title3)
						.fontWeight(.semibold)
						.multilineTextAlignment(.leading)
						.lineLimit(5)
						.padding(.top, 0.0)
					Text(album.artist?.name ?? "Unknown artist").fontWeight(.light)
						.multilineTextAlignment(.leading).lineLimit(1)
					Text("\(album.songsCount ?? 0) songs").fontWeight(.light).lineLimit(1)
				}.frame(maxWidth: .infinity, alignment: .leading)
			}.padding(16)
			.frame(maxWidth: .infinity, maxHeight: 225)
			List {
				ForEach(album.songs!, id: \.id) { song in
					HStack(alignment: .center) {
						Text("\(song.id)").fontWeight(.semibold).font(.caption)
						VStack(alignment: .leading) {
							Text(song.name ?? "").fontWeight(.semibold).font(.subheadline)
							Text(song.artist ?? "")
						}.padding(.leading, 8.0).frame(maxWidth: .infinity, alignment: .leading)
						Image(systemName: "ellipsis")
					}.onTapGesture {
						mediaPlayer.play(song: song, songs: album.songs!)
					}
					.frame(height: 42)
					.listRowSeparator(.hidden)
				}
			}.listStyle(.plain)
		}
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album(id: 1, name: "Nevermind",songsCount: 5, year: 1995, songs: [
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 2, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 3, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 4, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
			Song(id: 1, name: "Smell Like Teen Spirit", artist: "Nirvana", imageCover: nil, album: "Nevermind"),
		]))
    }
}
