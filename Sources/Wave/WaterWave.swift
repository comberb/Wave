//
//  WaterWave.swift
//  
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI

public struct WaterWave: Shape {
    // MARK: Properties
    
    public var progress: CGFloat
    public var strength: Double
    public var frequency: Double
    public var phase: Double
    
    public var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    // MARK: Lifecycle
    
    public init(progress: CGFloat = 0.0, strength: Double = 0.0, frequency: Double = 0.0, phase: Double = 0.0) {
        self.progress = progress
        self.strength = strength
        self.frequency = frequency
        self.phase = phase
    }
    
    // MARK: Methods
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        let width = Double(rect.width)
        let height = (1 - progress) * rect.height
        let midWidth = width / 2
        let oneOverMidWidth = 1 / midWidth
        
        let wavelength = width / frequency
        
        path.move(to: .zero)
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            
            let distanceFromMidWidth = x - midWidth
            let normalDistance = oneOverMidWidth * distanceFromMidWidth
            let parabola = -(normalDistance * normalDistance) + 1
            
            let sine = sin(relativeX + phase)
            let y = height + (parabola * strength * sine)
            path.addLine(to: .init(x: x, y: y))
        }
        
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.addLine(to: .init(x: .zero, y: rect.height))
        
        return Path(path.cgPath)
    }
}

