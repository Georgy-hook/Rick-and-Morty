//
//  CharactersListViewController.swift
//  Rick and Morthy
//
//  Created by Georgy on 19.08.2023.
//

import UIKit

protocol CharactersListViewControllerProtocol:AnyObject{
    func presentDetailsViewController(with character: Character)
}
final class CharactersListViewController: UIViewController {
    //MARK: - Variables
    private var charactersListServiceObserver: NSObjectProtocol?
    private let characterService = CharactersService.shared
    var charactersCollectionViewSetter: CharactersCollectionViewProtocol?
    // MARK: - Interface Elements
    private let charactersCollectionView = CharactersCollectionView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        applyConstraints()
        addObserver()
        
        characterService.fetchCharactersNextPage()
        
        charactersCollectionViewSetter = charactersCollectionView
        charactersCollectionViewSetter?.viewController = self
    }
    
}

// MARK: - Private layout Methods
extension CharactersListViewController{
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black BG")!
        title = "Characters"
        
    }
    
    private func addSubviews() {
        view.addSubview(charactersCollectionView)
    }
    
    private func applyConstraints() {
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Notification center
extension CharactersListViewController{
    private func addObserver(){
        charactersListServiceObserver = NotificationCenter.default
            .addObserver(
                forName: CharactersService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.charactersCollectionView.set(characters: characterService.characters)
                
            }
        self.charactersCollectionViewSetter?.set(characters: characterService.characters)
    }
}

extension CharactersListViewController:CharactersListViewControllerProtocol{
    
    func presentDetailsViewController(with character: Character){
        let characterDetailsViewController = CharacterDetailsViewController()
        characterDetailsViewController.character = character
        //characterDetailsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(characterDetailsViewController, animated: true)
        //present(characterDetailsViewController, animated: true)
    }
}
