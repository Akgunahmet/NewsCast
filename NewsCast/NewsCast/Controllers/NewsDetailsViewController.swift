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
    @IBOutlet weak var denemeButonImage: UIButton!
    @IBOutlet weak var newsAbstract: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfNewsIsFavorite()
        fetchDetails()
        
    }
    func checkIfNewsIsFavorite() {
            let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news?.title ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.first != nil {
                    setFavoriteButtonImage(isFavorite: true)
                }
            } catch {
                print("Error checking data: \(error)")
            }
        }
    func fetchDetails() {
        newsTitle.text = news?.title
        newsAbstract.text = news?.abstract
        if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            NewsImage.sd_setImage(with: url, placeholderImage: nil)
        }
    }

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {

        let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news?.title ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                if let existingFavorite = results.first {
                    context.delete(existingFavorite)
                    try context.save()
                    setFavoriteButtonImage(isFavorite: false)
                    showAlert(title: "Removed from favorites", message: "The news has been removed from favorites.")
                } else {
                    if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, error, _, _, _) in
                            if let error = error {
                                print("Error loading image: \(error)")
                                return
                            }
                            if let imageData = image?.sd_imageData() {
                                DispatchQueue.main.async {
                                    let newsFavorite = NewsFavorites(context: self.context)
                                    newsFavorite.favoriteTitle = self.news?.title
                                    newsFavorite.favoritesAbstract = self.news?.abstract
                                    newsFavorite.favoritesImage = imageData
                                    appDelegate.saveContext()
                                    self.setFavoriteButtonImage(isFavorite: true)
                                    self.showAlert(title: "Added to favorites", message: "The news has been added to favorites.")
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error checking data: \(error)")
            }
    }
    func setFavoriteButtonImage(isFavorite: Bool) {
         let buttonImageName = isFavorite ? "star.fill" : "star"
         let buttonImage = UIImage(systemName: buttonImageName)
         denemeButonImage.setImage(buttonImage, for: .normal)
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

