//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Luiz Gustavo Barros Campos on 08/09/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var satellite = false
    @State var showInfoCard = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation("", coordinate: predator.location) {
                    ZStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .shadow(color: .white, radius: 3)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                withAnimation {
                                    showInfoCard.toggle()
                                }
                            }
                        if showInfoCard {
                            InfoCard(predator: predator)
                                .offset(x: 100)
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                    }
                }
            }
        }
        .onTapGesture {
            withAnimation {
                showInfoCard ? showInfoCard.toggle() : nil
            }
        }
        .mapStyle(
            satellite ?
                .imagery(elevation: .realistic) : .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ?
                      "globe.americas.fill": "globe.americas"
                )
                .font(.largeTitle)
                .imageScale(.large)
                .padding(3)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 7))
                .shadow(radius: 3)
                .padding()
            }
        }
        .toolbarBackgroundVisibility(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(
        MapCamera(
            centerCoordinate: Predators().apexPredators[2].location,
            distance: 1000,
            heading: 250,
            pitch: 80
        )
    ))
    .preferredColorScheme(.dark)
}
