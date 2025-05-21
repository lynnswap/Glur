//
//  CompatibilityView.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 09/02/24.
//

import SwiftUI

internal struct CompatibilityModifier: ViewModifier {
    public var radius: CGFloat
    public var offset: CGFloat
    public var interpolation: CGFloat
    public var direction: BlurDirection
    public var isEnabled: Bool = true
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isEnabled {
                    content
                        .drawingGroup()
                        .allowsHitTesting(false)
                        .blur(radius: radius)
                        .scaleEffect(1+(radius*0.02))
                        .mask(gradientMask)
                }
            }
    }
    
    var gradientMask: some View {
        var (startPoint, endPoint) = direction.unitPoints
        
        return LinearGradient(stops: [
            .init(color: .clear, location: 0),
            .init(color: .clear, location: offset),
            .init(color: .black, location: offset+interpolation)
        ],
                       startPoint: startPoint,
                       endPoint: endPoint)
    }
}
