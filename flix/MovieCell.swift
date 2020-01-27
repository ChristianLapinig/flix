//
//  MovieCell.swift
//  flix
//
//  Created by Christian Lapinig on 1/26/20.
//  Copyright © 2020 Christian Lapinig. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
