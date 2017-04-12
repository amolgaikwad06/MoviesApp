//
//  MovieDetailTableViewCell.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/12/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
