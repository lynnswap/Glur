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
    
    @State private var dimensionPx: CGFloat = .greatestFiniteMagnitude
    private static let epsilon: CGFloat = 1e-4
    
    public func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGFloat.self) { geo in
                (direction == .down || direction == .up) ? geo.size.height : geo.size.width
            } action: { newDim in
                let px = newDim
                if px > 0 && px != dimensionPx { dimensionPx = px }
            }
            .modifier(
                GlurModifier(
                    radius: radius,
                    offset: offsetRatio,
                    interpolation: interpolation,
                    direction: direction
                )
            )
    }
    private var offsetRatio: CGFloat {
        guard dimensionPx > 0 else { return 1 }
        let ratio = length / dimensionPx
        switch direction {
        case .down, .right: return max(1 - ratio, 0)
        case .up, .left: return min( ratio, 1)
        }
    }
}
