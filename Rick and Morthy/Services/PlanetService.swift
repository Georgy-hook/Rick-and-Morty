//
//  PlanetService.swift
//  Rick and Morthy
//
//  Created by Georgy on 22.08.2023.
//

import Foundation

final class PlanetService {
    
    static let shared = PlanetService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private var isFetching = false
    
    func fetchPlanet(withURL url: String, completion: @escaping (Result<Planet, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        guard !isFetching else { return }
        isFetching = true
        
        task?.cancel()
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<PlanetResponse, Error>) in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let planetResponse):
                let planet = self.convertToPlanet(response: planetResponse)
                completion(.success(planet))
                self.task = nil
            case .failure(let error):
                completion(.failure(error))
                self.isFetching = false
            }
        }
        
        self.task = task
        task.resume()
    }
   
}

extension PlanetService {
    private func convertToPlanet(response: PlanetResponse) -> Planet {
        return Planet(
            id: response.id,
            name: response.name,
            type: response.type
        )
    }
}
