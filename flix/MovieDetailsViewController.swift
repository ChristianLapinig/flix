//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Christian Lapinig on 2/5/20.
//  Copyright © 2020 Christian Lapinig. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let posterPath = movie["poster_path"] as! String
        let posterUrl = createImageUrl(path: posterPath, size: "w185")
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = createImageUrl(path: backdropPath, size: "w780")
        
        backdropView.af_setImage(withURL: backdropUrl)
        posterView.af_setImage(withURL: posterUrl)
        titleLabel.text = movie["title"] as! String
        overviewLabel.text = movie["overview"] as! String
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
