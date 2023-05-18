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

enum DetailsSourceType {
    case newsCast
    case favorites
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class NewsDetailsViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    var news: News?
    var detailsSourceType: DetailsSourceType = .newsCast

    @IBOutlet weak var seeDetailsButton: UIButton!
    @IBOutlet weak var favoriteButtonImage: UIButton!
    @IBOutlet weak var newsAbstract: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
        checkIfNewsIsFavorite()
    }
    override func viewWillAppear(_ animated: Bool) {
        checkIfNewsIsFavorite()
    }
   

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        guard let news = news else {
            return
        }

        let isFavorite = isNewsFavorite(news)

        if isFavorite {
            removeNewsFromFavorites(news)
        } else {
            addNewsToFavorites(news)
        }
    }

    private func isNewsFavorite(_ news: News) -> Bool {
            let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news.title ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                return results.first != nil
            } catch {
                print("Error checking data: \(error)")
                return false
            }
        }
    private func removeNewsFromFavorites(_ news: News) {
           let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", news.title ?? "")
           
           do {
               let results = try context.fetch(fetchRequest)
               if let existingFavorite = results.first {
                   context.delete(existingFavorite)
                   try context.save()
                   setFavoriteButtonImage(isFavorite: false)
                   showAlert(title: "Removed from favorites", message: "The news has been removed from favorites.")
               }
           } catch {
               print("Error removing data: \(error)")
           }
       }

    private func addNewsToFavorites(_ news: News) {
            guard let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) else {
                return
            }
            
            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, error, _, _, _) in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                
                if let imageData = image?.sd_imageData() {
                    DispatchQueue.main.async {
                        let newsFavorite = NewsFavorites(context: self.context)
                        newsFavorite.favoriteTitle = news.title
                        newsFavorite.favoritesAbstract = news.abstract
                        newsFavorite.favoritesImage = imageData
                        if let urlString = news.url {
                            newsFavorite.favoriteURL = urlString
                        }
                        do {
                            try self.context.save()
                            self.setFavoriteButtonImage(isFavorite: true)
                            self.showAlert(title: "Added to favorites", message: "The news has been added to favorites.")
                        } catch {
                            print("Error saving data: \(error)")
                        }
                    }
                }
            }
        }

    @IBAction func seeDetailsButtonClicked(_ sender: Any) {
        if let urlString = news?.url,
           let url = URL(string: urlString)
        {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }

    private func checkIfNewsIsFavorite() {
        guard let newsTitle = news?.title else { return }

          let fetchRequest: NSFetchRequest<NewsFavorites> = NewsFavorites.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "favoriteTitle == %@", newsTitle)

          do {
              let results = try context.fetch(fetchRequest)
              let isFavorite = results.first != nil
              setFavoriteButtonImage(isFavorite: isFavorite)
          } catch {
              print("Error checking data: \(error)")
          }
      }

    private func setFavoriteButtonImage(isFavorite: Bool) {
        let buttonImageName = isFavorite ? "star.fill" : "star"
        let buttonImage = UIImage(systemName: buttonImageName)
        favoriteButtonImage.setImage(buttonImage, for: .normal)
    }

    private func fetchDetails() {
        newsTitle.text = news?.title
        newsAbstract.text = news?.abstract
        if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            NewsImage.sd_setImage(with: url, placeholderImage: nil)
        }
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}




