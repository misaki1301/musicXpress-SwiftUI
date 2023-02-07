//
//  SongCard.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/9/22.
//

import SwiftUI

struct SongCard: View {
    
	@EnvironmentObject var audioManager: MediaPlayerManager
    var song: Song
	var list: [Song]
    
    var body: some View {
        VStack(spacing: 0) {
            if song.imageCover != nil {
            Image(uiImage: song.imageCover!)
                .resizable()
                .frame(width: 134, height: 134)
            } else {
                Image("escape_cover")
                    .resizable()
                    .frame(width: 134, height: 134)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(song.name ?? "Melty Fantasia")
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                Text(song.artist ?? "Escape")
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
            }
            .padding(4.0)
            .frame(width: 134, alignment: .leading)
        }
        .onTapGesture {
			audioManager.play(song: song, songs: list)
        }
        .frame(width: 134, height: 178, alignment: .top)
        .background(Color(UIColor.secondarySystemBackground))
        //.shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 2)
    }
}

struct SongCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SongCard(song: Song(id: 1, name: "Melty Fantasia", artist: "Escape", imageCover: nil, path: nil), list: [Song]())
                .previewDevice("iPhone 11 Pro Max")
                .preferredColorScheme(.dark)
        }
    }
}
