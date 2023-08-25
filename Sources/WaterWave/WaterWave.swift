//
//  WaterWave.swift
//  
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI

struct WaterWave: Shape {
    @Binding var progress: CGFloat
    @Binding var strength: Double
    @Binding var frequency: Double
    var phase: Double
    
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
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

