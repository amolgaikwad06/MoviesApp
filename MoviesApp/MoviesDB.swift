//
//  MoviesDB.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/10/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import Foundation

class MovieDetail {
    var moviePosterPath:String?
    var movieTitle:String = ""
    var movieReleaseDate:String?
    var movieVoteCount:Int = 0
    var movieVoteAverage:Float = 0
    //var movieOverview:String = ""
    var movieLanguage: String = ""

    func populate(with dictionary:NSDictionary) {
        moviePosterPath = dictionary["poster_path"] as? String
        movieLanguage = dictionary["original_language"] as! String
        movieReleaseDate = dictionary["release_date"] as? String
        movieTitle = dictionary["title"] as! String
        movieVoteCount = dictionary["vote_count"] as! Int
        movieVoteAverage = dictionary["vote_average"] as! Float
    }
    class func populate(with array:NSArray) -> [MovieDetail] {
        var result:[MovieDetail] = []
        for item in array {
            let newItem = MovieDetail()
            newItem.populate(with: item as! NSDictionary)
            result.append(newItem)
        }
        return result
    }
}

class MoviesDB {
    var movieCurrentPageNumber: Int
    var movieTotalCount: Int
    var movieTotalPages: Int
    var movieDetail: [MovieDetail]
    init() {
        self.movieCurrentPageNumber = 0
        self.movieTotalCount = 0
        self.movieTotalPages = 0
        self.movieDetail = []
    }
    func populate(with dictionary: NSDictionary) {
        movieCurrentPageNumber = dictionary["page"] as! Int
        movieTotalCount = dictionary["total_results"] as! Int
        movieTotalPages = dictionary["total_pages"] as! Int
        movieDetail = MovieDetail.populate(with: dictionary["results"] as! [NSArray] as NSArray)
    }
    class func populate(with dictionary:NSDictionary) -> MoviesDB {
        let result = MoviesDB()
        result.populate(with: dictionary)
        return result
    }
}
