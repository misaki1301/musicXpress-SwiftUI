//
//  ArtistCard.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/11/22.
//

import SwiftUI

struct ArtistCard: View {
    
    var artist: Artist
    
    var body: some View {
        VStack {
            Image("minami_saki")
                .resizable()
                .frame(width: 96, height: 96)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
            Text("\(artist.name ?? "Minami Saki")")
				.font(.footnote)
				.multilineTextAlignment(.leading)
				.lineLimit(1)
        }
		.frame(width: 128)
    }
}

struct ArtistCard_Previews: PreviewProvider {
    static var previews: some View {
        ArtistCard(artist: Artist(id: 0, name: "Minami Saki", image: nil))
            .preferredColorScheme(.dark)
    }
}
