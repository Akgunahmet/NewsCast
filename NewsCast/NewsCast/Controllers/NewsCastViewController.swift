//
//  ViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit
import NewsCastAPI

class NewsCastViewController: UIViewController, LoadingShowable {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    let service: NewsServiceProtocol = NewsService()
    private var news: [News] = []
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNewsCast()
        navigationItem.title = "NewsCast"
    }
    // MARK: Fetch Function
    @IBAction func worldButtonClicked(_ sender: UIButton) {
        fetchNews(category: "world")
        navigationItem.title = "World News"
    }
    @IBAction func usButtonClicked(_ sender: UIButton) {
        fetchNews(category: "us")
        navigationItem.title = "US News"
    }
    @IBAction func scienceButtonClicked(_ sender: UIButton) {
        fetchNews(category: "science")
        navigationItem.title = "Science News"
    }
    func fetchNewsCast() {
        fetchNews(category: "home")
    }
    fileprivate func fetchNews(category: String) {
        self.showLoading()
        service.fetchNews(category: category) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .success(let news):
                self.news = news
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("FetchNews Error: \(error)")
            }
        }
    }
}
// MARK: Extension TableView
extension NewsCastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let news = self.news[indexPath.row]
        cell.configure(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = news[indexPath.row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsViewController
        detailsVC.news = selectedNews
        detailsVC.detailsSourceType = .newsCast
        navigationController?.pushViewController(detailsVC, animated: true)
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





