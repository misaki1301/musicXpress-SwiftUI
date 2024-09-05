//
//  Album.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 2/11/22.
//

import Foundation
import UIKit

struct Album: Hashable, Equatable {
	
	let id: Int
	let name: String
	let artist: Artist?
	let songsCount: Int?
	let year: Int
	let songs: [Song]?
	let artwork: UIImage?
	let isHiRes: Bool? = false
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
	}
	
	static func == (lhs: Album, rhs: Album) -> Bool {
		return lhs.name == rhs.name
	}
}
