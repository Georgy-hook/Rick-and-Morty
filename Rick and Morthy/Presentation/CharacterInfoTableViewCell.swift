//
//  CharacterInfoTableViewCell.swift
//  Rick and Morthy
//
//  Created by Georgy on 21.08.2023.
//

import UIKit

class CharacterInfoTableViewCell: UITableViewCell {
    
    static let reuseId = "CharacterInfoTableViewCell"
    
    let speciesLabelInactive: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "textSecondary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabelInactive: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "textSecondary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderLabelInactive: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "textSecondary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
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
    
    func configure(with character: Character) {
        speciesLabel.text = character.species
        genderLabel.text = character.gender.rawValue
        guard character.type != "" else{return}
        typeLabel.text = character.type
    }
}

// MARK: - Private layout Methods
extension CharacterInfoTableViewCell{
    private func configureUI() {
        backgroundColor = UIColor(named: "Black Card")!
    }
    
    private func addSubviews() {
        addSubview(speciesLabelInactive)
        addSubview(typeLabelInactive)
        addSubview(genderLabelInactive)
        addSubview(speciesLabel)
        addSubview(typeLabel)
        addSubview(genderLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // speciesLabelInactive constraints
            speciesLabelInactive.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            speciesLabelInactive.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // typeLabelInactive constraints
            typeLabelInactive.topAnchor.constraint(equalTo: speciesLabelInactive.bottomAnchor, constant: 16),
            typeLabelInactive.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // genderLabelInactive constraints
            genderLabelInactive.topAnchor.constraint(equalTo: typeLabelInactive.bottomAnchor, constant: 16),
            genderLabelInactive.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            genderLabelInactive.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // speciesLabel constraints
            speciesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // typeLabel constraints
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // genderLabel constraints
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            genderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
