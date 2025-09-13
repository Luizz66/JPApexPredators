//
//  InfoCard.swift
//  JPApexPredators
//
//  Created by Luiz Gustavo Barros Campos on 09/09/25.
//

import SwiftUI

struct InfoCard: View {
    let predator: ApexPredator
    
    var body: some View {
        HStack(spacing: 0) {
            Triangle()
                .fill(Color(white: 0.2))
                .frame(width: 12, height: 16)
            VStack(alignment: .leading, spacing: 8) {
                Text(predator.name)
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom, 8)
                Text("Appears in \(predator.movieScenes.count) Movies")
                    .font(.caption)
                    .padding(.bottom, 5)
            }
            .padding(7)
            .background(Color(white: 0.2))
            .clipShape(.buttonBorder)
            .shadow(radius: 8)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    InfoCard(predator: Predators().apexPredators[2])
        .preferredColorScheme(.dark)
}
