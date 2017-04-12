//
//  MoviesListViewTableTableViewController.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/9/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Foundation

class MoviesListViewTableViewController: UITableViewController {
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    let requestManager = APIRequestManager()
    var movieDBObject = MoviesDB()
    var posterPathURL : String = ""
    var validatedText: String {
        return searchController.searchBar.text!.replacingOccurrences(of: " ", with: "").lowercased()
    }
    var searchResults = [MovieDetail]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBarController()
        removeBackButtonTitle()
        addObserverForEvent()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_STRING {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! MovieDetailViewController
                destination.movieDetailObj = searchResults[indexPath.row]
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Custom Methods
    func addObserverForEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(MoviesListViewTableViewController.updateSearchResults), name: NSNotification.Name(rawValue: NOTIFICATION_STRING), object: nil)
    }
    
    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
    }
    
    func setUpSearchBarController() {
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = PLACEHOLDER_STRING
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults() {
        self.movieDBObject = requestManager.moviesDBObject
        searchResults = requestManager.searchResults
    }
    
    func loadMoreMovies(indexPath: IndexPath) {
        if indexPath.row + 1 == searchResults.count {
            if self.movieDBObject.movieCurrentPageNumber <= self.movieDBObject.movieTotalPages {
                requestManager.getNextPage(searchText: validatedText)
            }
        }
    }
    
    func configureCell(with indexPath: IndexPath, cell: MoviesListViewTableViewCell) {
        if let posterPath = searchResults[indexPath.row].moviePosterPath {
            posterPathURL = "\(IMAGE_URL)\(posterPath)"
            let url = URL(string: posterPathURL)
            let data = try? Data(contentsOf: url!)
            cell.moviePosterImageView.image = UIImage(data: data!)
            
        } else {
            posterPathURL = DEFAULT_POSTER_STRING
            cell.moviePosterImageView.image = UIImage(named: posterPathURL)
        }
        cell.movieTitleLabel.text = searchResults[indexPath.row].movieTitle
        if let releaseDate = searchResults[indexPath.row].movieReleaseDate {
            cell.movieReleaseYearLabel.text = releaseDate
        } else {
            cell.movieReleaseYearLabel.text = NO_RESULT
        }
        
        cell.moviePosterImageView.layer.cornerRadius = 30.0
        cell.moviePosterImageView.clipsToBounds = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MoviesListViewTableViewCell
        configureCell(with: indexPath, cell: cell)
        loadMoreMovies(indexPath: indexPath)
        return cell
    }
}

// MARK: - Extension
extension MoviesListViewTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestManager.resetSearch()
        updateSearchResults()
        requestManager.search(queryString: validatedText)
    }
}

