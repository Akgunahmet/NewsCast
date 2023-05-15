//
//  PopularMovieCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit

import NewsCastAPI
import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var byline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(news: News) {

        title.text = news.title
        abstract.text = news.abstract
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                   movieImage.sd_setImage(with: url, placeholderImage: nil)
               }
        byline.text = news.byline
    }
}
