//
//  LengthBandBaseModifier.swift
//  Glur
//
//  Created by lynnswap on 2025/05/21.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
struct LengthBandBaseModifier<M: ViewModifier>: ViewModifier {
    var length: CGFloat
    var direction: BlurDirection
    var makeModifier: (CGFloat) -> M

    @State private var dimensionPx: CGFloat = .greatestFiniteMagnitude

    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGFloat.self) { geo in
                (direction == .down || direction == .up) ? geo.size.height : geo.size.width
            } action: { newDim in
                if newDim > 0 && newDim != dimensionPx { dimensionPx = newDim }
            }
            .modifier(makeModifier(offsetRatio))
    }

    private var offsetRatio: CGFloat {
        guard dimensionPx > 0 else { return 1 }
        let ratio = length / dimensionPx
        switch direction {
        case .down, .right: return max(1 - ratio, 0)
        case .up, .left: return min(ratio, 1)
        }
    }
}
