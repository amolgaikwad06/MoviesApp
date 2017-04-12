//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/12/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    var movieDetailObj = MovieDetail()
    
    // MARK: - IBOutlet
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
        displayPosterImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: - Custom Methods
    func setNavigationBar() {
        title = NAVIGATION_TITLE
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func setUpMovieDetailTableView() {
        movieDetailTableView.estimatedRowHeight = 36.0
        movieDetailTableView.rowHeight = UITableViewAutomaticDimension
        movieDetailTableView.backgroundColor = UIColor.tableViewBackgroundColor()
        movieDetailTableView.tableFooterView = UIView(frame: CGRect.zero)
        movieDetailTableView.separatorColor = UIColor.tableViewSeparatorColor()
    }
    func displayPosterImage(){
        if let poster = movieDetailObj.moviePosterPath {
            let url = URL(string: "\(IMAGE_URL)\(poster)")
            let data = try? Data(contentsOf: url!)
            moviePosterImageView.image = UIImage(data: data!)
        }
        else {
            moviePosterImageView.image = UIImage(named: DEFAULT_POSTER_STRING)
        }
    }
    func configureMovieDetailCell(with indexPath: IndexPath, cell: MovieDetailTableViewCell) {
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = MOVIE_TITLE
            cell.valueLabel.text = movieDetailObj.movieTitle
        case 1:
            cell.fieldLabel.text = MOVIE_RELEASED_ON
            cell.valueLabel.text = movieDetailObj.movieReleaseDate
        case 2:
            cell.fieldLabel.text = MOVIE_VOTE_COUNT
            cell.valueLabel.text = String(movieDetailObj.movieVoteCount)
        case 3:
            cell.fieldLabel.text = MOVIE_AVERAGE
            cell.valueLabel.text = String(movieDetailObj.movieVoteAverage)
        case 4:
            cell.fieldLabel.text = MOVIE_LANGUAGE
            cell.valueLabel.text = movieDetailObj.movieLanguage
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
    }
    
}

// MARK: - Extension
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for:
            indexPath) as! MovieDetailTableViewCell
        configureMovieDetailCell(with: indexPath, cell: cell)
        return cell
    }
}









