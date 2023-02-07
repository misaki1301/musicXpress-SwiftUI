//
//  Album.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 2/11/22.
//

import Foundation
import UIKit

struct Album: Hashable, Equatable {
	
	var id: Int
	var name: String
	var artist: Artist?
	var songsCount: Int?
	var year: Int
	var songs: [Song]?
	var artwork: UIImage?
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}
	
	static func == (lhs: Album, rhs: Album) -> Bool {
		return lhs.name == rhs.name
	}
}
