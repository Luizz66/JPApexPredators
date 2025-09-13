//
//  Predators.swift
//  JPApexPredators
//
//  Created by Luiz Gustavo Barros Campos on 02/09/25.
//
// VIEWMODEL
import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []//array immutable
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoging JSON data: \(error)")
            }
        }
    }
}

extension [ApexPredator] {
    func filter(by type: APType) -> [ApexPredator] {
        type == .all ? self : self.filter { $0.type == type }
    }
    
    func filterMovie(by movie: APMovies) -> [ApexPredator] {
        movie == .all ? self : self.filter { $0.movies.contains(movie) }
    }
    
    func sort(by alphabetical: Bool) -> [ApexPredator] {
        self.sorted {
            alphabetical ? $0.name < $1.name : $0.id < $1.id
        }
    }
    
    func search(for searchText: String) -> [ApexPredator] {
        searchText.isEmpty ? self : self.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

