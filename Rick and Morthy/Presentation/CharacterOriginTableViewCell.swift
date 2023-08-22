//
//  CharacterOriginTableViewCell.swift
//  Rick and Morthy
//
//  Created by Georgy on 21.08.2023.
//

import UIKit

class CharacterOriginTableViewCell: UITableViewCell {
    
    static let reuseId = "CharacterOriginTableViewCell"
    
    let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Planet")
        imageView.backgroundColor = UIColor(named: "Black Elements")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    let planetNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let planetTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "primary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        addSubviews()
        applyConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8
        self.layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
 
        self.clipsToBounds = false
    }
    
    func configure(with origin: Planet) {
        planetNameLabel.text = origin.name
        planetTypeLabel.text = origin.type
    }
}

// MARK: - Private layout Methods
extension CharacterOriginTableViewCell{
    private func configureUI() {
        backgroundColor = UIColor(named: "Black Card")!
    }
    
    private func addSubviews() {
        addSubview(planetImageView)
        addSubview(planetNameLabel)
        addSubview(planetTypeLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // planetImageView constraints
            planetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            planetImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            planetImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            planetImageView.widthAnchor.constraint(equalToConstant: 64),
            planetImageView.heightAnchor.constraint(equalToConstant: 64),
            // planetNameLabel constraints
            planetNameLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            planetNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            // planetTypeLabel constraints
            planetTypeLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            planetTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
    }
}
