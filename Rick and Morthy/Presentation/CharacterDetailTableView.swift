//
//  CharacterDetailTableView.swift
//  Rick and Morthy
//
//  Created by Georgy on 21.08.2023.
//

import UIKit
class CharacterDetailTableView:UITableView,UITableViewDataSource{
    
    //MARK: - Initialization
    init(){
        super.init(frame: .zero, style: .plain)
        
        dataSource = self
        delegate = self
        
        allowsSelection = false
        separatorStyle = .none
        backgroundColor = UIColor(named: "Black BG")
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        register(CharacterInfoTableViewCell.self, forCellReuseIdentifier: CharacterInfoTableViewCell.reuseId)
        register(CharacterOriginTableViewCell.self, forCellReuseIdentifier: CharacterOriginTableViewCell.reuseId)
        register(CharacterEpisodesTableViewCell.self, forCellReuseIdentifier: CharacterEpisodesTableViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Variables
    
    
    var character: Character?
    var episodes:[Episode] = []
    
    enum CellType {
        case info
        case origin
        case episodes
    }
    //MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
          return 3
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          switch section{
          case 2:
              return episodes.count
          default:
              return 1
          }
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let character = character else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoTableViewCell.reuseId, for: indexPath) as! CharacterInfoTableViewCell
            cell.configure(with: character)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterOriginTableViewCell.reuseId, for: indexPath) as! CharacterOriginTableViewCell
    
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterEpisodesTableViewCell.reuseId, for: indexPath) as! CharacterEpisodesTableViewCell
            cell.configure(with: episodes[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headers = ["Info", "Origin", "Episodes"]
        return headers[section]
    }
}

extension CharacterDetailTableView:UITableViewDelegate{
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 61
    }
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
}

extension CharacterDetailTableView {
    func appendEpisode(episode: Episode) {
        let section = 2
        let row = episodes.count
        let indexPath = IndexPath(row: row, section: section)
        
        episodes.append(episode)
        self.performBatchUpdates({
            self.insertRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
    
    func configureOriginCell(with planet:Planet){
        let indexPath = IndexPath(row: 0, section: 1)
        let cell = self.cellForRow(at: indexPath) as? CharacterOriginTableViewCell
        cell?.configure(with: planet)
    }
}


//extension CharacterDetailTableView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(named: "Black BG")
//        
//        let titleLabel = UILabel()
//        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerView.addSubview(titleLabel)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//        ])
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 61
//    }
//}
