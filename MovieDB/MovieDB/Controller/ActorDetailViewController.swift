//
//  ActorDetailViewController.swift
//  MovieDB
//
//  Created by Daulet Omar on 10.11.2024.
//

import UIKit

class ActorDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var actor: Actor?  // Set this from the previous view controller
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // Actor image view
    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = actor?.name
        
        // Set up actor image if available
        if let imageName = actor?.image, let image = UIImage(named: imageName) {
            actorImageView.image = image
        } else {
            actorImageView.image = UIImage(systemName: "person.fill") // Placeholder image
        }
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        
        // Set up the table header view for actor image
        let headerView = UIView()
        headerView.addSubview(actorImageView)
        
        // Define constraints for the image view in the header
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            actorImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableView.tableHeaderView = headerView
        
        // Add the table view to the view hierarchy
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Personal details and Biography
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3 // Name, Birthday, Place of Birth
        case 1:
            return 1 // Biography
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let actor = actor else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Name: \(actor.name)"
            case 1:
                cell.textLabel?.text = "Birthday: \(actor.birthday)"
            case 2:
                cell.textLabel?.text = "Place of Birth: \(actor.placeOfBirth)"
            default:
                break
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Biography: \(actor.biography)"
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal Details"
        case 1:
            return "Biography"
        default:
            return nil
        }
    }
}
