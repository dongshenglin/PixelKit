//
//  ConvertPIX.swift
//  PixelKit
//
//  Created by Anton Heestand on 2019-04-25.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import CoreGraphics

public class ConvertPIX: PIXSingleEffect {
    
    override open var shader: String { return "effectSingleConvertPIX" }
    
    var resScale: CGSize {
        switch mode {
        case .domeToEqui: return CGSize(width: 2.0, height: 1.0)
        case .equiToDome: return CGSize(width: 0.5, height: 1.0)
        case .cubeToEqui: return CGSize(width: (3.0 / 4.0) * 2.0, height: 1.0)
//        case .equiToCube: return CGSize(width: (4.0 / 3.0) / 2.0, height: 1.0)
        case .squareToCircle: return CGSize(width: 1.0, height: 1.0)
        case .circleToSquare: return CGSize(width: 1.0, height: 1.0)
        }
    }
    
    // MARK: - Public Properties
    
    public enum ConvertMode: String, CaseIterable {
        case domeToEqui
        case equiToDome
        case cubeToEqui
//        case equiToCube
        case squareToCircle
        case circleToSquare
        var index: Int {
            switch self {
            case .domeToEqui: return 0
            case .equiToDome: return 1
            case .cubeToEqui: return 2
//            case .equiToCube: return 3
            case .squareToCircle: return 4
            case .circleToSquare: return 5
            }
        }
    }
    public var mode: ConvertMode = .squareToCircle
    
    public var xRotation: LiveFloat = 0.0
    public var yRotation: LiveFloat = 0.0
    
    // MARK: - Property Helpers
    
    public override var liveValues: [LiveValue] {
        return [xRotation, yRotation]
    }
    
    public override var uniforms: [CGFloat] {
        return [CGFloat(mode.index), xRotation.uniform, yRotation.uniform]
    }
    
}
