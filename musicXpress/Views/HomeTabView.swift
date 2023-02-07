//
//  HomeTabView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/9/22.
//

import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var audioFileManager: AudioFileManager
	@EnvironmentObject var audioPlayerManager: MediaPlayerManager
    
    var columns = [
        GridItem(.flexible())
    ]
    
    var columnsNewlyAdded = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var data = ["Melty Fantasia", "Sakashima no Kotoba", "Asayake no Crescendo", "Thank You", "Flyers", "Glow Map", "La cucaracha"]
    
    var body: some View {
            ScrollView(.vertical) {
				Group {
					HStack {
						VStack(alignment: .leading, spacing: 0) {
							Image("kotoha_cheers")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.clipShape(Circle())
								.frame(width: 64, height: 64)
								.padding(.bottom, 34)
								.padding(.leading, 20)
							Text("Move with the\nmusic you love")
								.fontWeight(.semibold)
								.font(.title2)
								.multilineTextAlignment(.leading)
								.padding(.leading, 20)
						}
						Spacer()
						Image("sony_headphone")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 199, height: 199)
							.offset(x: 25, y: -60)
					}
					.frame(width: UIScreen.main.bounds.width)
					LazyVGrid(columns: columns) {
						Section(header:
									HStack {
							Text("Recently played").fontWeight(.medium).font(.title3)
							Spacer()
						}) {
							ScrollView(.horizontal, showsIndicators: false) {
								LazyHGrid(rows: columns, spacing: 8) {
									ForEach(audioFileManager.songs, id: \.id) {
										item in
										SongCard(song: item, list: audioFileManager.songs)
									}
								}
							}
						}
					}
					LazyVGrid(columns: columns) {
						Section(header:
									HStack {
							Text("Artists")
								.fontWeight(.medium)
								.font(.title3)
							Spacer()
						}) {
							ScrollView(.horizontal, showsIndicators: false) {
								LazyHGrid(rows: columns, spacing: 8) {
									ForEach(audioFileManager.artists, id: \.id) {
										item in
										ArtistCard(artist: item)
									}
								}
							}
						}
					}
					LazyVGrid(columns: columnsNewlyAdded) {
						Section(header: HStack {
							Text("Newly Added")
								.fontWeight(.medium)
								.font(.title3)
							Spacer()
						}) {
							ForEach(audioFileManager.songs.shuffled().prefix(9), id: \.id) {
								item in
								SongCard(song: item, list: audioFileManager.songs.shuffled())
							}
						}
					}
					VStack {
						
					}.frame(height: 65)
				}
				.padding(.leading, 16.0)
			}
	}
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
            .environmentObject(AudioFileManager())
    }
}
