//
//  Movie.swift
//  MovieDB
//
//  Created by Daulet Omar on 10.11.2024.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let image: String?
    let genre: [String]
    let rating: Double?
    let cast: [Actor]
}
