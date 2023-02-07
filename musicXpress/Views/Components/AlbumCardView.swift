//
//  AlbumCardView.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 7/11/22.
//

import SwiftUI

struct AlbumCardView: View {
	var album: Album
    var body: some View {
		VStack(alignment: .leading) {
			if album.artwork != nil {
				Image(uiImage: album.artwork!)
					.resizable()
					.frame(height: 200)
			} else {
				Image("escape_cover")
					.resizable()
					.frame(height: 200)
			}
			VStack {
				Text("\(!album.name.isEmpty ? album.name : "Unknown Album")")
					.font(.subheadline)
					.fontWeight(.semibold)
					.multilineTextAlignment(.leading)
					.lineLimit(1)
					.frame(maxWidth: .infinity, alignment: .leading)
				if album.artist != nil {
					Text("\(album.artist!.name!)").fontWeight(.light).multilineTextAlignment(.leading)
						.lineLimit(1)
						.frame(maxWidth: .infinity, alignment: .leading)
				} else {
					Text("Unknown artist").fontWeight(.light).multilineTextAlignment(.leading)
						.lineLimit(1)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
			}.padding(.horizontal, 8)
		}
		.padding(.bottom, 8)
		.background(Color(UIColor.secondarySystemBackground))
    }
}

struct AlbumCardView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCardView(album: Album(id: 1, name: "MTV Unplugged", year: 1997))
    }
}
