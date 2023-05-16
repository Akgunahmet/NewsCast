//
//  FavoritesCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 16.05.2023.
//

import UIKit
import NewsCastAPI

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var favoritesTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(news: News) {

        
        
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                   favoritesImage.sd_setImage(with: url, placeholderImage: nil)
               }
    }
}
