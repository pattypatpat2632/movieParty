//
//  DataStore.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import Foundation

class DataStore: MovieSearchDelegate {
    
    static let sharedInstance = DataStore()
    fileprivate var movies: [Movie] = []
    weak var delegate: DataStoreDelegate?
    
    
    private init() {
        
    }
    
    func updateWithNewData(data: [[String : Any]]) {
        print("updating DataStore with Data from APICLient")
        for dictionary in data {
            let title = dictionary["Title"] as? String ?? ""
            let year = dictionary["Year"] as? String ?? ""
            let imdbID = dictionary["imdbID"] as? String ?? ""
            let posterURL = dictionary["Poster"] as? String ?? ""
            let newMovie = Movie(title: title, year: year, imdbID: imdbID, posterURL: posterURL)
            movies.append(newMovie)
            print(newMovie.title)
        }
        print("data store is telling delegate to update with new movies")
        delegate?.updateWithNewMovies(movies: movies)
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
}

protocol DataStoreDelegate: class {
    func updateWithNewMovies(movies: [Movie])
}
