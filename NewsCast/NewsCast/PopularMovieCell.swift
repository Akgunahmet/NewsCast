//
//  PopularMovieCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit

import NewsCastAPI
import UIKit

class PopularMovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: News) {
        //preparePosterImage(with: movie.posterPath)
        title.text = movie.title
        abstract.text = movie.abstract
    }
    
//    private func preparePosterImage(with urlString: String?) {
//        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
//
//        if let url = URL(string: fullPath) {
//            movieImage.sd_setImage(with: url)
//        }
//    }

}
