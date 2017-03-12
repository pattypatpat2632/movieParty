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
    weak var globalMovieSearchBar: UISearchBar!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieSearchBar = UISearchBar()
        navigationItem.titleView = movieSearchBar
        movieSearchBar.sizeToFit()
        globalMovieSearchBar = movieSearchBar
        layoutCells()
        store.delegate = self
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCellView
        cell.movie = movies[indexPath.item]

        return cell
    }

     func updateWithNewMovies(movies: [Movie]) {
        self.movies = movies
        self.collectionView?.reloadData()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        guard let searchString = globalMovieSearchBar.text else {return}
        globalMovieSearchBar.text = ""
        movies = []
        DispatchQueue.main.async{
        OmdbApiClient.getMeSomeMovies(titleSearch: searchString)
        self.collectionView?.reloadData()
       }
    }
    
    func layoutCells() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenHeight/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView?.collectionViewLayout = layout
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "movieDetailSegue" else {print("segue identifier error"); return}
        let indexPaths = self.collectionView?.indexPathsForSelectedItems
        if let selectedCellNumber = indexPaths?[0].item {
            OmdbApiClient.getDetailedInfo(forTitle: movies[selectedCellNumber].title)
            let dest = segue.destination as! ViewController
            dest.movie = movies[selectedCellNumber]
            print("selected movie! \(movies[selectedCellNumber].title)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
