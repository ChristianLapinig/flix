//
//  MoviesGridViewController.swift
//  flix
//
//  Created by Christian Lapinig on 2/6/20.
//  Copyright © 2020 Christian Lapinig. All rights reserved.
//

import UIKit

class MoviesGridViewController: UIViewController {
    @IBOutlet weak var moviesGridView: UICollectionView!
    
    // Define properties
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesGridView.dataSource = self
        moviesGridView.delegate = self
        
        let layout = moviesGridView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        getMovies()
    }
    
    // Get similar movies
    func getMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.moviesGridView.reloadData()
           }
        }
        task.resume()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = moviesGridView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
               
        // Pass selected movie to details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
    }
}

extension MoviesGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesGridView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        let posterUrl = createImageUrl(path: posterPath, size: "w185")
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }
}
