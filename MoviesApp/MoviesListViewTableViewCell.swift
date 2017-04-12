//
//  MoviesListViewTableViewCell.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/12/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class MoviesListViewTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
