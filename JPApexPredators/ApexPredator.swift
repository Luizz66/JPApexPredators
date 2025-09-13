//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Luiz Gustavo Barros Campos on 02/09/25.
//
// MODEL
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: APMovies.AllCases
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum APMovies: String, Decodable, CaseIterable, Identifiable {
    case all
    case JP1 = "Jurassic Park"
    case JP2 = "The Lost World: Jurassic Park"
    case JP3 = "Jurassic Park III"
    case JW1 = "Jurassic World"
    case JW2 = "Jurassic World: Fallen Kingdom"
    case JW3 = "Jurassic World: Dominion"
    
    var id: APMovies {
        self
    }
    
}

enum APType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land //rawvalue = "land"
    case air
    case sea
    
    var id: APType {
        self
    }
    
    var style: Color {
        switch self {
        case .all: .black
        case .land: .brown
        case .air: .teal
        case .sea: .blue
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
