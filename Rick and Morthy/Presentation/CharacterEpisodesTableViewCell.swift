//
//  CharacterEpisodesTableViewCell.swift
//  Rick and Morthy
//
//  Created by Georgy on 21.08.2023.
//

import UIKit

class CharacterEpisodesTableViewCell: UITableViewCell {
    
    static let reuseId = "CharacterEpisodesTableViewCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Black Card")!
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "primary")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodeDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "textSecondary")
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10))
        self.clipsToBounds = false
    }
    
    func configure(with episode: Episode) {
        let components = episode.episode.components(separatedBy: "E")
        if components.count == 2 {
            let season = components[0].replacingOccurrences(of: "S", with: "")
            let episodeNumber = components[1]
            episodeNameLabel.text = episode.name
            episodeInfoLabel.text = "Episode \(episodeNumber), Season \(season)"
            episodeDateLabel.text = episode.airDate
        }
    }
}

// MARK: - Private layout Methods
extension CharacterEpisodesTableViewCell{
    private func configureUI() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(episodeNameLabel)
        containerView.addSubview(episodeInfoLabel)
        containerView.addSubview(episodeDateLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // episodeNameLabel constraints
            episodeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            episodeNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 15),
            
            // episodeInfoLabel constraints
            episodeInfoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
            episodeInfoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            episodeInfoLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 16),
            
            // episodeDateLabel constraints
            episodeDateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            episodeDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
}
