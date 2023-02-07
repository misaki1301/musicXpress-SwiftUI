//
//  FileHelpers.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/11/22.
//

import Foundation

extension URL {
    var typeIdentifier: String? { (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier }
    var isMP3: Bool { typeIdentifier == "public.mp3" }
    var isFLAC: Bool { typeIdentifier == "public.audio" }
    var isJPG: Bool { typeIdentifier == "cover.jpg"}
    var isPNG: Bool { typeIdentifier == "cover.png"}
    var localizedName: String? { (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName }
    var hasHiddenExtension: Bool {
        get { (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.hasHiddenExtension = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
