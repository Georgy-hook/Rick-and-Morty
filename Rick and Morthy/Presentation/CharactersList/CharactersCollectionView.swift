//
//  CharactersCollectionView.swift
//  Rick and Morthy
//
//  Created by Georgy on 20.08.2023.
//
import UIKit

protocol CharactersCollectionViewProtocol:AnyObject{
    func set(characters: [Character])
    var viewController: CharactersListViewControllerProtocol? {get set}
}
class CharactersCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let leftDistanceToView: CGFloat = 20
    let rightDistanceToView: CGFloat = 20
    let galleryMinimumLineSpacing: CGFloat = 16
    var galleryItemWidth: CGFloat = 0
    
    let characterService = CharactersService.shared
    var characters = [Character]()
    
    weak var viewController: CharactersListViewControllerProtocol?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        galleryItemWidth = (UIScreen.main.bounds.width - leftDistanceToView - rightDistanceToView - (galleryMinimumLineSpacing)) / 2
        
        backgroundColor = UIColor(named: "Black BG")!
        delegate = self
        dataSource = self
        register(CharactersCollectionViewCell.self, forCellWithReuseIdentifier: CharactersCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: leftDistanceToView, bottom: 0, right: rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.reuseId, for: indexPath) as! CharactersCollectionViewCell
        let character = characters[indexPath.row]
        cell.ShowActivityIndicator()
        cell.characterImageView.loadImage(from: character.image) { success in
            cell.HideActivityIndicator()

            if success {
                cell.nameLabel.text = character.name
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: galleryItemWidth, height: frame.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            characterService.fetchCharactersNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        viewController?.presentDetailsViewController(with: character)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharactersCollectionView:CharactersCollectionViewProtocol{
    
    func set(characters: [Character]) {
        let oldCount = self.characters.count
        let newCount = characters.count
        self.characters = characters
        if oldCount != newCount {
            self.performBatchUpdates{
                let indexPaths = (oldCount..<newCount).map {
                    IndexPath(item:$0, section: 0)
                }
                self.insertItems(at: indexPaths)
            } completion: { _ in }
        }
    }
}
