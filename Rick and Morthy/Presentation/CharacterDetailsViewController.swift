//
//  CharacterDetailsViewController.swift
//  Rick and Morthy
//
//  Created by Georgy on 19.08.2023.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    // MARK: - Interface Elements
    private let activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .green // Замените на ваш цвет
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = CharacterDetailTableView()
    
    // MARK: - Properties
    
    var character: Character?
    private let episodeService = EpisodeService.shared
    private let planetService = PlanetService.shared
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        configureUI()
        addSubviews()
        applyConstraints()
    }
    
}

// MARK: - Private layout Methods
extension CharacterDetailsViewController {
    private func configureUI() {
        guard let character = character else {return}
        
        view.backgroundColor = UIColor(named: "Black BG")
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.character = character
        
        characterImageView.loadImage(from: character.image) { result in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        nameLabel.text = character.name
        statusLabel.text = character.status.rawValue
    }
    
    private func addSubviews() {
        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.widthAnchor.constraint(equalToConstant: 148),
            characterImageView.heightAnchor.constraint(equalToConstant: 148),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 24),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo:characterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo:characterImageView.centerYAnchor)
            
        ])
    }
}

extension CharacterDetailsViewController{
    func downloadData(){
        guard let character = character else{return}
        
        character.episode.forEach{
            episodeService.fetchEpisode(withURL: $0){result in
                switch result {
                case .success(let episode):
                    self.tableView.appendEpisode(episode: episode)
                case .failure(let error):
                    print("Error loading episode: \(error)")
                }
            }
        }
        
        planetService.fetchPlanet(withURL: character.origin.url){result in
            
            switch result {
            case .success(let planet):
                self.tableView.configureOriginCell(with: planet)
            case .failure(let error):
                print("Error loading episode: \(error)")
            }
        }
    }
}
