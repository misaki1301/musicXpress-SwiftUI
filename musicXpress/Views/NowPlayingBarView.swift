//
//  NowPlayingBarView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 7/11/22.
//

import SwiftUI

struct NowPlayingBarView: View {
	
	@EnvironmentObject var audioManager: MediaPlayerManager
	var namespace: Namespace.ID
	
    var body: some View {
		ZStack {
			Rectangle()
				.foregroundColor(Color.white.opacity(0.0))
				.frame(width: UIScreen.main.bounds.width, height: 65)
				.background(Blur())
				.matchedGeometryEffect(id: "rectangle", in: namespace)
			HStack {
				Button(action: {}) {
					HStack {
						if audioManager.currentSong?.imageCover != nil {
							Image(uiImage: audioManager.currentSong!.imageCover!)
								.resizable()
								.frame(width:45, height: 45)
								.padding(.leading)
								.matchedGeometryEffect(id: "cover", in: namespace)
						} else {
							Image("escape_cover")
								.resizable()
								.frame(width: 45, height: 45)
								.padding(.leading)
								.matchedGeometryEffect(id: "cover", in: namespace)
						}
						VStack {
							Text(audioManager.currentSong?.name ?? "Melty Fantasia")
								.padding(.leading, 10)
								.lineLimit(1)
								.frame(maxWidth: .infinity, alignment: .leading)
								//.matchedGeometryEffect(id: "title", in: namespace)
							Text(audioManager.currentSong?.artist ?? "EScape")
								.padding(.leading, 10)
								.lineLimit(1)
								.frame(maxWidth: .infinity, alignment: .leading)
								//.matchedGeometryEffect(id: "artist", in: namespace)
							
						}
						Spacer()
					}
				}
				.buttonStyle(PlainButtonStyle())
				Button(action: {}) {
					Image(systemName: "backward.fill").font(.title3)
				}
				.buttonStyle(.plain)
				if !audioManager.isPlaying {
					Button(action: {audioManager.pause()}) {
						Image(systemName: "play.fill").font(.title3)
							.frame(width: 40, height: 40)
							.contentShape(Rectangle())
					}
					.buttonStyle(.plain)
					//.padding(.horizontal)
				} else {
					Button(action: {audioManager.pause()}) {
						Image(systemName: "pause.fill").font(.title3)
							.frame(width: 40, height: 40)
							.contentShape(Rectangle())
					}
					.buttonStyle(.plain)
					//.padding(.horizontal)
				}
				Button(action: {}) {
					Image(systemName: "forward.fill").font(.title3)
				}
				.buttonStyle(.plain)
				.padding(.trailing, 30)
			}
		}
    }
}

struct NowPlayingBarView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
    static var previews: some View {
		NowPlayingBarView(namespace: namespace)
			.environmentObject(MediaPlayerManager())
    }
}
