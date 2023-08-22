//
//  CharactersCollectionViewCell.swift
//  Rick and Morthy
//
//  Created by Georgy on 20.08.2023.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let reuseId = "CharactersCollectionViewCell"
    
    // MARK: - Interface Elements
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureUI()
        addSubviews()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8
        self.layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        self.clipsToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private layout Methods
extension CharactersCollectionViewCell{
    private func configureUI() {
        backgroundColor = UIColor(named: "Black Card")!
    }
    
    private func addSubviews() {
        addSubview(characterImageView)
        addSubview(nameLabel)
        addSubview(activityIndicator)
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // characterImageView constraints
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            characterImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16),
            
            // nameLabel constraints
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
        ])
    }
}

extension CharactersCollectionViewCell{
    
    func ShowActivityIndicator(){
        activityIndicator.startAnimating()
    }
    
    func HideActivityIndicator(){
        activityIndicator.stopAnimating()
    }
}
