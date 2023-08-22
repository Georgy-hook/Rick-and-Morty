//
//  EpisodeService.swift
//  Rick and Morthy
//
//  Created by Georgy on 22.08.2023.
//

import Foundation

final class EpisodeService {
    
    static let shared = EpisodeService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    func fetchEpisode(withURL url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        guard let url = URL(string: url) else{return}
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<EpisodeResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let episodeResponse):
                let episode = self.convertToEpisode(response: episodeResponse)
                completion(.success(episode))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
   
}

extension EpisodeService {
    private func convertToEpisode(response: EpisodeResponse) -> Episode {
        return Episode(
            id: response.id,
            name: response.name,
            airDate: response.airDate,
            episode: response.episode
        )
    }

}
