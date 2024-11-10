import UIKit

class MovieDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movie: Movie?  // Set this from the previous view controller
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // Movie image view for the header
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = movie?.title
        
        // Set up movie image if available
        if let imageName = movie?.image, let image = UIImage(named: imageName) {
            movieImageView.image = image
        } else {
            movieImageView.image = UIImage(systemName: "photo") // Placeholder image
        }
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.register(ActorCell.self, forCellReuseIdentifier: "ActorCell")
        
        // Set up the table header view for movie image
        let headerView = UIView()
        headerView.addSubview(movieImageView)
        
        // Define constraints for the image view in the header
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 200)
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
        return 3 // Details, Genre, and Cast
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // Movie details
        case 1:
            return movie?.genre.count ?? 0 // Genre list
        case 2:
            return movie?.cast.count ?? 0 // Cast list
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
            Title: \(movie.title)
            Overview: \(movie.overview)
            Release Date: \(movie.releaseDate)
            Rating: \(movie.rating ?? 0)
            """
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            cell.textLabel?.text = movie.genre[indexPath.row]
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell", for: indexPath) as! ActorCell
            let actor = movie.cast[indexPath.row]
            cell.configure(with: actor)
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Movie Details"
        case 1:
            return "Genres"
        case 2:
            return "Cast"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedActor = movie?.cast[indexPath.row]
        let actorDetailVC = ActorDetailViewController()
        actorDetailVC.actor = selectedActor
        navigationController?.pushViewController(actorDetailVC, animated: true)
    }
}
