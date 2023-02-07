//
//  BlurEffects.swift
//  musicXpress
//
//  Created by Paul Frank Pacheco Carpio on 6/12/22.
//

import Foundation
import UIKit
import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemChromeMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
