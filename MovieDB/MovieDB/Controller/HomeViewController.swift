//
//  ViewController.swift
//  MovieDB
//
//  Created by Daulet Omar on 10.11.2024.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        view.backgroundColor = .white
        
        // Set up the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        if let imageName = movie.image, let image = UIImage(named: imageName) {
            cell.movieImageView.image = image
        } else {
            cell.movieImageView.image = UIImage(systemName: "photo") // Placeholder image
        }
        
        return cell
    }
    
    // Adjust the row height based on image size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280 // Customize this value as needed
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let selectedMovie = movies[indexPath.row]
        
        let detailViewController = MovieDetailViewController()
        detailViewController.movie = selectedMovie
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    private func getMovies() {
        let movie1 = Movie(
            id: 1,
            title: "The Great Adventure",
            overview: "An epic tale of a group of explorers venturing into the unknown to discover hidden secrets.",
            releaseDate: "2023-05-12",
            image: "great_adventure.jpg",
            genre: ["Action", "Adventure"],
            rating: 8.3,
            cast: [
                Actor(name: "John Smith", image: "john_smith.jpg", birthday: "1980-06-15", placeOfBirth: "Los Angeles, CA", biography: "John is a well-known actor famous for his roles in adventure and action films."),
                Actor(name: "Anna Williams", image: "anna_williams.jpg", birthday: "1985-04-22", placeOfBirth: "New York, NY", biography: "Anna is a talented actress with a wide range of roles in both independent and blockbuster films.")
            ]
        )

        let movie2 = Movie(
            id: 2,
            title: "Mystery in the Mist",
            overview: "A detective is called to a secluded town to solve a mysterious disappearance.",
            releaseDate: "2022-10-28",
            image: "mystery_mist.jpg",
            genre: ["Mystery", "Thriller"],
            rating: 7.5,
            cast: [
                Actor(name: "David Johnson", image: "david_johnson.jpg", birthday: "1977-03-08", placeOfBirth: "Chicago, IL", biography: "David is an acclaimed actor known for his riveting performances in mystery and drama films."),
                Actor(name: "Sophia Martinez", image: "sophia_martinez.jpg", birthday: "1990-09-17", placeOfBirth: "Miami, FL", biography: "Sophia has captivated audiences with her roles in thriller and crime series.")
            ]
        )

        let movie3 = Movie(
            id: 3,
            title: "Love and Laughter",
            overview: "A romantic comedy about two individuals who find love in unexpected ways.",
            releaseDate: "2021-02-14",
            image: "love_laughter.jpg",
            genre: ["Romance", "Comedy"],
            rating: 6.8,
            cast: [
                Actor(name: "Emily Rose", image: "emily_rose.jpg", birthday: "1992-12-01", placeOfBirth: "Austin, TX", biography: "Emily is a bright star in romantic comedies, bringing charm and humor to the screen."),
                Actor(name: "Michael Brown", image: "michael_brown.jpg", birthday: "1988-07-23", placeOfBirth: "Seattle, WA", biography: "Michael is known for his comedic timing and heartfelt performances.")
            ]
        )

        let movie4 = Movie(
            id: 4,
            title: "The Last Frontier",
            overview: "A sci-fi epic about a team of astronauts embarking on a mission to save humanity.",
            releaseDate: "2024-09-10",
            image: "last_frontier.jpg",
            genre: ["Science Fiction", "Adventure"],
            rating: 9.0,
            cast: [
                Actor(name: "William Harris", image: "william_harris.jpg", birthday: "1975-11-12", placeOfBirth: "San Francisco, CA", biography: "William is a veteran actor known for leading roles in sci-fi and drama films."),
                Actor(name: "Claire Bennett", image: "claire_bennett.jpg", birthday: "1995-03-19", placeOfBirth: "Boston, MA", biography: "Claire is an up-and-coming actress with standout performances in action and sci-fi movies.")
            ]
        )

        let movie5 = Movie(
            id: 5,
            title: "The Hidden Melody",
            overview: "A drama about a young prodigy who struggles to find her voice in the world of classical music.",
            releaseDate: "2020-08-15",
            image: "hidden_melody.jpg",
            genre: ["Drama", "Music"],
            rating: 8.1,
            cast: [
                Actor(name: "Lara Kim", image: "lara_kim.jpg", birthday: "2000-01-05", placeOfBirth: "San Diego, CA", biography: "Lara is an emerging talent, known for her powerful roles in musical dramas."),
                Actor(name: "Thomas Lee", image: "thomas_lee.jpg", birthday: "1983-04-10", placeOfBirth: "Dallas, TX", biography: "Thomas has a strong background in musical theater and film, captivating audiences with his singing and acting.")
            ]
        )
        
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movies.append(movie4)
        movies.append(movie5)
    }
}
