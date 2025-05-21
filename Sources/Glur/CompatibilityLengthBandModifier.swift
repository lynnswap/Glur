//
//  CompatibilityLengthBandModifier.swift
//  Glur
//
//  Created by lynnswap on 2025/05/21.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
struct CompatibilityLengthBandModifier: ViewModifier {
    var radius: CGFloat
    var length: CGFloat
    var interpolation: CGFloat
    var direction: BlurDirection
    var isEnabled: Bool = true

    func body(content: Content) -> some View {
        content.modifier(
            LengthBandBaseModifier(length: length, direction: direction) { offset in
                CompatibilityModifier(
                    radius: radius,
                    offset: offset,
                    interpolation: interpolation,
                    direction: direction,
                    isEnabled: isEnabled
                )
            }
        )
    }
}
