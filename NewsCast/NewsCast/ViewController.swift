//
//  ViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit
import NewsCastAPI

class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    let service: PopularMovieServiceProtocol = PopularMovieService()
    private var movies: [News] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    fileprivate func fetchMovies() {
       // self.showLoading()
        service.fetchPopularMovies { [weak self] response in
            guard let self else { return }
          //  self.hideLoading()
            switch response {
            case .success(let movies):
                print("KERIM: \(movies)")
                self.movies = movies
                self.tableView.reloadData()
            case .failure(let error):
                print("KERIM: \(error)")
            }
        }
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! PopularMovieCell
        let movie = self.movies[indexPath.row]
        cell.configure(movie: movie)
        
        return cell
    }

    
//    private func calculateHeight() -> CGFloat {
//        let cellWitdh = collectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
//        let posterImageHeight = cellWitdh * Constants.cellPosterImageRatio
//        
//        return (Constants.cellTitleHeight + posterImageHeight)
//    }
}


