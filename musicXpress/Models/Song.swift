//
//  Song.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 20/10/22.
//

import Foundation
import UIKit

struct Song {
	var id: Int = .zero
	var name: String? = .empty
	var artist: String? = .empty
	var imageCover: UIImage? = nil
	var path: URL? = nil
	var album: String? = .empty
}
