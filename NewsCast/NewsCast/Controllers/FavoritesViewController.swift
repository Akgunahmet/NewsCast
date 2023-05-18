//
//  FavoritesViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//


import UIKit
import CoreData
import SafariServices

class FavoritesViewController: UIViewController {
    // MARK: Properties
    let context = appDelegate.persistentContainer.viewContext
    var favoriteNewsList = [NewsFavorites]()
    @IBOutlet weak var tableView: UITableView!
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    // MARK: Fetch Function
    func fetchData() {
        do {
            favoriteNewsList = try context.fetch(NewsFavorites.fetchRequest())
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        showConfirmationAlert()
    }
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NewsFavorites.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            favoriteNewsList.removeAll()
            tableView.reloadData()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    // MARK: Alert
    func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Delete All News", message: "Are you sure you want to delete all news?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteAllData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}
// MARK: TableView Extension
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteNews = favoriteNewsList[indexPath.row]
        if let urlString = favoriteNews.favoriteURL, let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            let favorite = self?.favoriteNewsList[indexPath.row]
            self?.context.delete(favorite!)
            appDelegate.saveContext()
            self?.favoriteNewsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favorite = favoriteNewsList[indexPath.row]
            context.delete(favorite)
            appDelegate.saveContext()
            favoriteNewsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
// MARK: NSFetchedResultsController Extension
extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}












