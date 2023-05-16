//
//  FavoritesCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 16.05.2023.
//

import UIKit


class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var favoritesTitle: UILabel!
    
    @IBOutlet weak var favoritesAbstract: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setup(favorite: NewsFavorites) {
        
        favoritesTitle.text = "\(favorite.favoriteTitle ?? "") "
        favoritesAbstract.text = "\(favorite.favoritesAbstract ?? "") "
        if let imageData = favorite.favoritesImage {
            favoritesImage.image = UIImage(data: imageData)
        } else {
            favoritesImage.image = UIImage(named: "placeholder") // or any other default image
        }
    }
}
