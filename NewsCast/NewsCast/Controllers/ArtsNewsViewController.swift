//
//  ArtsNewsViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 15.05.2023.
//

import UIKit
import NewsCastAPI

class ArtsNewsViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    let service: NewsServiceProtocol = NewsService()
    private var news: [News] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchArtsNews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.darkGray
    }
    fileprivate func fetchArtsNews() {
       // self.showLoading()
        service.fetchArtsNews { [weak self] response in
            guard let self else { return }
          //  self.hideLoading()
            switch response {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
            case .failure(let error):
                print("KERIM: \(error)")
            }
        }
    }
}
extension ArtsNewsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtsCell", for: indexPath) as! ArtsCell
        let news = self.news[indexPath.row]
        cell.setup(news: news)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = news[indexPath.row]
        let newDetailsVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsViewController
        newDetailsVC.news = selectedNews
        self.navigationController?.pushViewController(newDetailsVC, animated: true)
        
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let news = self.news[indexPath.row]
            if news.isValid && !news.title!.isEmpty && !news.abstract!.isEmpty && ((news.multimedia?.first?.url?.isEmpty) != nil) {
                return 165.0
            } else {
                return 0.0
            }
        }
}
