//
//  MovieCollectionVC.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MovieCollectionVC: UICollectionViewController, DataStoreDelegate {
    let store = DataStore.sharedInstance
    var movies: [Movie] = []
    var displayedMovies: [Movie] = []
    weak var globalMovieSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var movieSearchBar = UISearchBar()
        navigationItem.titleView = movieSearchBar
        movieSearchBar.sizeToFit()
        globalMovieSearchBar = movieSearchBar
        store.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "movieDetailSegue" else {print("segue identifier error"); return}
        let indexPaths = self.collectionView?.indexPathsForSelectedItems
        print(indexPaths?[0].item)
        if let selectedCell = indexPaths?[0].item {
            OmdbApiClient.getDetailedInfo(forTitle: displayedMovies[selectedCell].title)
        var dest = segue.destination as! ViewController
        dest.movie = displayedMovies[selectedCell]
            print("selected movie! \(displayedMovies[selectedCell].title)")
        }
    }
 

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionCellView
        cell?.movie = movies[indexPath.item]
        if let movie = cell?.movie {
        displayedMovies.append(movie)
        }
        return cell!
    }

 
    func updateWithNewMovies(movies: [Movie]) {
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        guard let searchString = globalMovieSearchBar.text else {return}
        globalMovieSearchBar.text = ""
        movies = []
        displayedMovies = []
        DispatchQueue.main.async{
        self.collectionView?.reloadData()
       }

        OmdbApiClient.getMeSomeMovies(titleSearch: searchString)
        self.collectionView?.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate


    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
