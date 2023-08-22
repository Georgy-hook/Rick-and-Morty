//
//  CharactersService.swift
//  ImageFeed
//
//  Created by Georgy on 19.08.2023.
//

import Foundation

final class CharactersService {
    
    static let shared = CharactersService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private (set) var characters: [Character] = []
    
    private var lastLoadedPage: Int = 0
    
    static let didChangeNotification = Notification.Name(rawValue: "CharactersListProviderDidChange")
    
    private var isFetching = false
    
    func fetchCharactersNextPage() {
        guard !isFetching else { return }
        isFetching = true
        
        let nextPage = lastLoadedPage + 1
        self.lastLoadedPage = nextPage
        task?.cancel()
        let request = CharactersListURLRequest(page: nextPage)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<CharacterResponse, Error>) in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let body):
                body.results.forEach{ element in
                    self.characters.append(self.convertToCharacter(element: element))
                }
                NotificationCenter.default
                    .post(
                        name: CharactersService.didChangeNotification,
                        object: self,
                        userInfo: ["charactersList": characters])
                
                self.task = nil
            case .failure(let error):
                print(error)
                self.isFetching = false
            }
        }
        
        self.task = task
        task.resume()
    }
}

extension CharactersService{
    private func CharactersListURLRequest(page: Int) -> URLRequest {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    private func convertToCharacter(element: CharacterResultElement) -> Character {

        return Character(
            id: element.id,
            name: element.name,
            status: element.status,
            species: element.species,
            type: element.type,
            gender: element.gender,
            origin: element.origin,
            location: element.location,
            image: element.image,
            episode: element.episode,
            url: element.url,
            created: element.created
        )
    }
    
}
extension CharactersService{
    func cleanCharacters(){
        characters = []
    }
}
