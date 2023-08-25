//
//  WaterWaveView.swift
//  
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI

struct WaterWaveView: View {
    @State private var phase = 0.0
    @State private var progress: CGFloat = 0.5
    @State var strength: Double
    @State var frequency: Double
    
    var body: some View {
        VStack(alignment: .center) {
            WaterWave(
                progress: $progress,
                strength: $strength,
                frequency: $frequency,
                phase: phase
            )
            .fill(LinearGradient.rainbow)
            .frame(width: 100, height: 400)
            .mask(RoundedRectangle(cornerRadius: 50))
            .overlay(content: {
                //Water Drops shapes
                ZStack{
                    Circle()
                        .fill(.white.opacity(0.1))
                        .frame(width: 15, height: 15)
                        .offset(x: -20)
                    
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 15, height: 15)
                        .offset(x:40, y: 30)
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 25, height: 25)
                        .offset(x: -30, y: 80)
                    
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 10, height: 10)
                        .offset(x: 40, y: 100)
                    
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 20, height: 20)
                        .offset(x: 50, y: 70)
                }
            })
            
            Slider(value: $progress)
                .padding()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(
                .linear(duration: 0.75)
                .repeatForever(autoreverses: false)
            ) {
                self.phase = .pi * 2
            }
        }
    }
}

struct WaterWaveView_Previews: PreviewProvider {
    static var previews: some View {
        WaterWaveView(strength: 5, frequency: 10)
    }
}
