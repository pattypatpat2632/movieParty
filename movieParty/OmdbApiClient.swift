//
//  OmdbApiClient.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//


//created new branch
import Foundation

class OmdbApiClient{
    static weak var movieSearchDelegate: MovieSearchDelegate? = DataStore.sharedInstance
    
    class func getMeSomeMovies (titleSearch:String){
        print("getMeSomeMovies called")
        let titleSearchF = formatForSearch(titleSearch)
        let omdbAddr = "https://omdbapi.com/?s="+titleSearchF
        let omdbUrl = URL(string: omdbAddr)
        let session = URLSession.shared
        guard let omdbUrla = omdbUrl else {print("something fucked up"); return}
        print("URL check complete")
        let task = session.dataTask(with: omdbUrla, completionHandler: {(data , response, error) in
            do{
                guard let data = data else {print("something's not right"); return}
                print("data received")
                let sessionData = try JSONSerialization.jsonObject(with: data, options: [])
                if let searchDict = sessionData as? [String : Any]{
                    if let searchResults = searchDict["Search"] as? [[String:Any]]{
                        print("movies found in API Client")
                        print("sending results to dataStore")
                        movieSearchDelegate?.updateWithNewData(data: searchResults)
                    }
                }
            }catch{}
            
        })
        task.resume()
    }

    fileprivate class func formatForSearch(_ searchString: String) -> String{
        let temp = searchString.components(separatedBy: CharacterSet(charactersIn: " ,./`!@#$%^&*()_{}|[]<>?:"))
        return temp.joined(separator: "+")
    }
    
}

protocol MovieSearchDelegate:class{
    func updateWithNewData(data: [[String:Any]])
    
}
