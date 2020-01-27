//
//  MoviesViewController.swift
//  flix
//
//  Created by Christian Lapinig on 1/26/20.
//  Copyright © 2020 Christian Lapinig. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    
    // Initialize movies property
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        getMovies()
    }
    
    // Get movies from API
    func getMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.moviesTableView.reloadData()
           }
        }
        task.resume()
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

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        return cell
    }
}
