//
//  ArtsCell.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit
import NewsCastAPI

class ArtsCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var artsNewsImage: UIImageView!
    @IBOutlet weak var artsNewsTitle: UILabel!
    @IBOutlet weak var artsNewsAbstract: UILabel!
    @IBOutlet weak var artsNewsByline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: Function
    func setup(news: News) {
        artsNewsTitle.text = news.title
        artsNewsAbstract.text = news.abstract
        artsNewsByline.text = news.byline
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            artsNewsImage.sd_setImage(with: url, placeholderImage: nil)
        }
    }
}
