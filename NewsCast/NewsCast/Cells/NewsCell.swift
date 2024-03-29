//
//  PopularMovieCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit
import NewsCastAPI

class NewsCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var byline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: Function
    func configure(news: News) {
        title.text = news.title
        abstract.text = news.abstract
        byline.text = news.byline
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            newsImage.sd_setImage(with: url, placeholderImage: nil)
        }
    }
}
