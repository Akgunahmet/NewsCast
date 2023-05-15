//
//  FavoritesViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit
import NewsCastAPI

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImages: UIImageView!
    
    @IBOutlet weak var newsImage2: UIImageView!
    @IBOutlet weak var newTitleLabel2: UILabel!
    
    private var news: [News] = []
    //tableviewcell
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UserDefaults.standard.object(forKey: "title")
        if let newsTitles = title as? String {
            newsTitleLabel.text = "\(newsTitles)"

            if let imageData = UserDefaults.standard.data(forKey: "newsImage") {
                let image = UIImage(data: imageData)
                newsImages.image = image
            }
        
        }
    
        
    }
}



    

