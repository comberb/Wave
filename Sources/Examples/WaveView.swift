//
//  WaveView.swift
//  
//
//  Created by Ben Comber on 25/08/2023.
//

import SwiftUI

struct WaveView: View {
    @State private var phase = 0.0
    
    var body: some View {
        ZStack {
            Wave(
                strength: 20,
                frequency: 20,
                phase: phase
            )
            .stroke(Color.blue, lineWidth: 5)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(
                .linear(duration: 0.5)
                .repeatForever(autoreverses: false)
            ) {
                self.phase = .pi * 2
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WaveView()
    }
}
