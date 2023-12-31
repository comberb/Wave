
import SwiftUI

public struct Wave: Shape {
    // MARK: Properties
    
    var strength: Double
    var frequency: Double
    var phase: Double
    
    public var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    // MARK: Lifecycle
    
    public init(strength: Double = 0.0, frequency: Double = 0.0, phase: Double = 0.0) {
        self.strength = strength
        self.frequency = frequency
        self.phase = phase
    }
    
    // MARK: Methods
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2
        let oneOverMidWidth = 1 / midWidth
        
        let wavelength = width / frequency
        
        path.move(to: .init(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            
            let distanceFromMidWidth = x - midWidth
            let normalDistance = oneOverMidWidth * distanceFromMidWidth
            let parabola = -(normalDistance * normalDistance) + 1
            
            let sine = sin(relativeX + phase)
            let y = parabola * strength * sine + midHeight
            path.addLine(to: .init(x: x, y: y))
        }
        
        return Path(path.cgPath)
    }
}
