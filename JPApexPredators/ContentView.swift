//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Luiz Gustavo Barros Campos on 02/09/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText: String = ""
    @State var isAlphabetical: Bool = false
    @State var currentSelection = APType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: isAlphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator,
                                   position: .camera(MapCamera(
                                        centerCoordinate: predator.location,
                                        distance: 30000))
                    )
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:100,height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack (alignment: .leading){
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.style)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)//1st animation
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation{//2st animation
                            isAlphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: isAlphabetical ? "textformat" : "film")
                            .symbolEffect(.bounce, value: isAlphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {//3st animation
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label : {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
