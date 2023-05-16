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
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
class NewsDetailsViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    var news : News?
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
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
    var isDataSaved = false
 @IBAction func AddButton(_ sender: UIBarButtonItem) {
     let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news?.title ?? "")
         
         do {
             let results = try context.fetch(fetchRequest)
             if results.first != nil {
                 // Aynı veri zaten kaydedilmiş, alert göster
                 showAlert(title: "Already added", message: "This data is already in your favorites.")
             } else {
                 // Veri kaydedilmemiş, kaydet
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
                                 newsFav.favoritesAbstract = self.news?.abstract
                                 newsFav.favoritesImage = imageData
                                 appDelegate.saveContext()
                             }
                         }
                     }
                 }
               
                 showAlert(title: "Added to favorites", message: "The data has been added to your favorites.")
             }
         } catch {
             print("Error checking data: \(error)")
         }
//     if isDataSaved {
//         let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news?.title ?? "")
//
//            do {
//                let results = try context.fetch(fetchRequest)
//                if let favorite = results.first {
//                    // Silme işlemi
//                    context.delete(favorite)
//                    appDelegate.saveContext()
//
//                    // Ekranı güncelleme vb. işlemler yapabilirsiniz.
//                }
//            } catch {
//                print("Error deleting data: \(error)")
//            }
//         showAlert(title: "Removed from Favorites", message: "The data has been removed from your favorites.")
//      } else {
//               if let media = news?.multimedia?.first,
//                  let urlString = media.url,
//                  let url = URL(string: urlString) {
//
//                   SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, error, _, _, _) in
//                       if let error = error {
//                           print("Error loading image: \(error)")
//                           return
//                       }
//                       if let imageData = image?.sd_imageData() {
//                           DispatchQueue.main.async {
//                               let newsFav = NewsFavorites(context: self.context)
//                               newsFav.favoriteTitle = self.news?.title
//                               newsFav.favoritesAbstract = self.news?.abstract
//                               newsFav.favoritesImage = imageData
//                               appDelegate.saveContext()
//                           }
//                       }
//                   }
//               }
//
//          isDataSaved = true
//
//          showAlert(title: "Added to favorites", message: "The data has been added to your favorites.")
//      }

    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func seeDetailsButtonClicked(_ sender: Any) {
        if let url = URL(string: (news?.url)!) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
 
}

