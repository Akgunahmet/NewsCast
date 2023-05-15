//
//  ArtsCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit
import NewsCastAPI
import SDWebImage

class ArtsCell: UITableViewCell {
    
    @IBOutlet weak var artsNewsImage: UIImageView!
    
    @IBOutlet weak var artsNewsTitle: UILabel!
    
    @IBOutlet weak var artsNewsAbstract: UILabel!
    @IBOutlet weak var artsNewsByline: UILabel!
    func configur(news: News) {

        artsNewsTitle.text = news.title
        artsNewsByline.text = news.byline
        artsNewsAbstract.text = news.abstract
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                   artsNewsImage.sd_setImage(with: url, placeholderImage: nil)
               }
    }
}
