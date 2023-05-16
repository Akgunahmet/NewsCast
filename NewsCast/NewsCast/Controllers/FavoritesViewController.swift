//
//  FavoritesViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit
import CoreData
class FavoritesViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    var favoriteNewsList = [NewsFavorites]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
        func fetchData(){
            do{
                favoriteNewsList = try context.fetch(NewsFavorites.fetchRequest())
            } catch {
                print("Hata")
            }
        }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = favoriteNewsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCell

        cell.setup(favorite: favorite)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (action, view, completionHandler) in
            let favorite = self.favoriteNewsList[indexPath.row]
            self.context.delete(favorite)
            appDelegate.saveContext()
            self.favoriteNewsList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favorite = self.favoriteNewsList[indexPath.row]
            self.context.delete(favorite)
            appDelegate.saveContext()
            self.favoriteNewsList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
}


    

