//
//  ItemGrid.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/11/22.
//

import SwiftUI

struct ItemGrid: View {
    
    var columns: [GridItem]
    var artists: [Artist]
    var songs: [Song]
    var type: elementType
    var titleSegment: String
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Section(header:
                        HStack {
                Text(titleSegment)
                    .fontWeight(.medium)
                    .font(.title3)
                Spacer()
            }) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: columns, spacing: 8) {
                        if type == .artist {
                            ForEach(artists, id: \.id) {
                                item in
                                ArtistCard(artist: item)
                            }
                        } else {
                            ForEach(songs, id: \.id) {
                                item in
                                SongCard(song: item, list: songs)
                            }
                        }
                    }
                }
            }
        }
    }
}

enum elementType {
    case artist
    case song
}

struct ItemGrid_Previews: PreviewProvider {
    static var previews: some View {
        ItemGrid(columns: [GridItem(.flexible())], artists: [], songs: [Song(id: 1, name: "Melty Fantasia", artist: "Escape", imageCover: nil, path: nil)], type: .song, titleSegment: "New songs")
    }
}
