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
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        showConfirmationAlert()
    }
    func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Delete All News", message: "Are you sure you want to delete all news?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteAllData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NewsFavorites")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            // Silme işlemi başarılı oldu, gerekirse diğer işlemler yapılabilir.
        } catch {
            // Hata durumunda işlemler yapılabilir veya hata mesajı gösterilebilir.
            print("Error deleting data: \(error)")
        }
        self.favoriteNewsList.removeAll()
        self.tableView.reloadData()
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
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
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


    

