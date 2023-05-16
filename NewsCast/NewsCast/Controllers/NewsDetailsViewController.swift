//
//  NewsDetailsViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 12.05.2023.
//

import UIKit
import NewsCastAPI
import SDWebImage
import SafariServices
import Alamofire
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class NewsDetailsViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    //var favoriteNewsList = [NewsFavorites]()
    
    
    var news : News?
    @IBOutlet weak var newsAbstract: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchDetails()
    }
    func fetchDetails() {
        newsTitle.text = news?.title
        newsAbstract.text = news?.abstract
        if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                   NewsImage.sd_setImage(with: url, placeholderImage: nil)
               }
    }
 @IBAction func AddButton(_ sender: UIBarButtonItem) {
//     var newsFav = NewsFavorites(context: context)
//
//     newsFav.favoriteTitle = news?.title
//
//
//     appDelegate.saveContext()

     
//     if let media = news?.multimedia?.first,
//     let urlString = media.url,
//     let url = URL(string: urlString),
//     let imageData = try? Data(contentsOf: url) {
//
//         let newsFav = NewsFavorites(context: context)
//
//      newsFav.favoriteTitle = news?.title
//      newsFav.favoritesImage = imageData
//
//      appDelegate.saveContext()
//
//
//  }
     if let media = news?.multimedia?.first,
        let urlString = media.url,
        let url = URL(string: urlString) {
         
         SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, error, _, _, _) in
             if let error = error {
                 print("Error loading image: \(error)")
                 return
             }
             if let imageData = image?.sd_imageData() {
                 DispatchQueue.main.async {
                     let newsFav = NewsFavorites(context: self.context)
                     newsFav.favoriteTitle = self.news?.title
                     newsFav.favoritesImage = imageData
                     appDelegate.saveContext()
                 }
             }
         }
     }
    }

    @IBAction func seeDetailsButtonClicked(_ sender: Any) {
        if let url = URL(string: (news?.url)!) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
 
}

