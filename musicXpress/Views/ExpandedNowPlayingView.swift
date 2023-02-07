//
//  ExpandedNowPlayingView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/11/22.
//

import SwiftUI

struct ExpandedNowPlayingView: View {
	
	@EnvironmentObject var mediaPlayer: MediaPlayerManager
	@Environment(\.colorScheme) var colorScheme
	
	@State var currentProgress: CGFloat = 0.0
	
	
	
	var namespace: Namespace.ID
	
	
    var body: some View {
		GeometryReader { geo in
			ZStack {
				Rectangle()
					.background(colorScheme == .dark ? .black : .white)
					.matchedGeometryEffect(id: "rectangle", in: namespace)
				if mediaPlayer.currentSong?.imageCover != nil {
					Image(uiImage: mediaPlayer.currentSong!.imageCover!)
						.resizable()
						.scaledToFill()
						.blur(radius: 32)
				} else {
					Image("escape_cover")
						.resizable()
						.scaledToFill()
						.blur(radius: 32)
				}
				Rectangle()
					.background(colorScheme == .dark ? .black : .white)
					//.frame(width: geo.size.width, height: geo.size.height)
					.blur(radius: 4)
					.opacity(0.25)
				VStack {
					if mediaPlayer.currentSong?.imageCover != nil {
						Image(uiImage: mediaPlayer.currentSong!.imageCover!)
							.resizable()
							.scaledToFit()
							.cornerRadius(16)
							.padding(.top, 64)
							.matchedGeometryEffect(id: "cover", in: namespace)
					} else {
						Image("escape_cover")
							.resizable()
							.scaledToFit()
							.cornerRadius(16)
						//.frame(maxHeight: .infinity)
							.padding(.top, 64)
							.matchedGeometryEffect(id: "cover", in: namespace)
					}
					VStack(spacing: 8) {
						HStack {
							Image(systemName: "star")
							Text("\(mediaPlayer.currentSong?.name ?? "Unknow Song")")
								.font(.title2)
								.fontWeight(.semibold)
								.multilineTextAlignment(.leading)
								.lineLimit(1)
								.frame(width: geo.size.width * 0.8)
								.matchedGeometryEffect(id: "title", in: namespace)
							Image(systemName: "plus.circle")
						}.padding(.horizontal, 16)
						Text("\(mediaPlayer.currentSong?.artist ?? "Unknown artist")")
							.font(.title2)
							.multilineTextAlignment(.leading)
							.frame(width: geo.size.width * 0.95)
							.lineLimit(1)
						Text("\(mediaPlayer.currentSong?.album ?? "Unknown album")")
							.font(.title2)
							.multilineTextAlignment(.leading)
							.frame(width: geo.size.width * 0.95)
							.lineLimit(1)
						VStack {
							ZStack(alignment: .leading) {
								RoundedRectangle(cornerRadius: 20)
									.foregroundColor(.gray)
									.frame(width: 400, height: 20)
								RoundedRectangle(cornerRadius: 20)
									.foregroundColor(.purple)
									.frame(width: 400 * currentProgress, height: 20)
							}
							HStack {
								Text("\(mediaPlayer.player.currentTime)")
								Spacer()
								Text("\(mediaPlayer.player.duration)")
							}
						}.padding(16.0)
							.frame(width: geo.size.width)
						HStack(spacing: 32.0) {
							Button(action: {}) {
								Image(systemName: "shuffle").font(.system(size: 36))
							}.buttonStyle(.plain)
							Button(action: {}) {
								Image(systemName: "backward.fill").font(.system(size: 36))
							}.buttonStyle(.plain)
							if mediaPlayer.isPlaying {
								Button(action: {mediaPlayer.pause()}) {
									Image(systemName: "pause.fill").font(.system(size: 42))
								}.buttonStyle(.plain)
							} else {
								Button(action: {mediaPlayer.pause()}) {
									Image(systemName: "play.fill").font(.system(size: 42))
								}.buttonStyle(.plain)
							}
							Button(action: {}) {
								Image(systemName: "forward.fill").font(.system(size: 36))
							}.buttonStyle(.plain)
							Button(action: {}) {
								Image(systemName: "repeat").font(.system(size: 36))
							}.buttonStyle(.plain)
						}
					}.frame(maxHeight: geo.size.height, alignment: .center)
				}.ignoresSafeArea()
			}
			.frame(width: geo.size.width)
			.ignoresSafeArea()
		}
    }
	
	func startLoading() {
		_ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
			withAnimation() {
				self.currentProgress += 0.01
				if self.currentProgress >= 1.0 {
					timer.invalidate()
				}
			}
		}
	}
}

struct ExpandedNowPlayingView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
	static var previews: some View {
		
		return ExpandedNowPlayingView(namespace: namespace)
			.environmentObject(MediaPlayerManager())
    }
}
