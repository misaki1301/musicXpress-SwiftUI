//
//  AlbumTabView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 2/11/22.
//

import Collections
import SwiftUI

struct AlbumTabView: View {
	
	@EnvironmentObject var fileManager: AudioFileManager
	
	let columns = [GridItem(.flexible()), GridItem(.flexible())]
	
    var body: some View {
		NavigationView {
			ScrollView {
				LazyVGrid(columns: columns) {
					ForEach(fileManager.albums, id: \.self) { album in
						NavigationLink {
							AlbumDetailView(album: album)
						} label: {
							AlbumCardView(album: album)
						}.buttonStyle(.plain)
					}
				}
				VStack {
					EmptyView()
				}.frame(height: 65)
			}
		}
    }
}

struct AlbumTabView_Previews: PreviewProvider {
    static var previews: some View {
		let album = Album(id: 1, name: "MTV Unplugged", artist: Artist(id: 1, name: "Nirvana", image: nil), songsCount: 1, year: 1997, songs: [], artwork: nil)
		let albums = [
			album
		]
		
		let fileManager = AudioFileManager()
		fileManager.albums = albums
		
		return AlbumTabView()
			.environmentObject(fileManager)
    }
}
