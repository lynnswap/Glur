//
//  GlurLengthBandModifier.swift
//  Glur
//
//  Created by lynnswap on 2025/05/21.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
public struct GlurLengthBandModifier: ViewModifier {
    public var radius: CGFloat
    public var length: CGFloat
    public var interpolation: CGFloat
    public var direction: BlurDirection
    public var isEnabled: Bool = true
    
    public func body(content: Content) -> some View {
        content.modifier(
            LengthBandBaseModifier(length: length, direction: direction) { offset in
                GlurModifier(
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
