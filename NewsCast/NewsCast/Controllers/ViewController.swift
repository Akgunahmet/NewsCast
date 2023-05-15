//
//  ViewController.swift
//  NewsCast
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import UIKit
import NewsCastAPI

class ViewController: UIViewController {


    @IBOutlet weak var worldButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let service: NewsServiceProtocol = NewsService()
    private var news: [News] = []
   // private var media: [Media] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHomeNews()
        navigationItem.title = "Home News"
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func worldButtonClicked(_ sender: UIButton) {
      fetchWorldNews()
        navigationItem.title = "World News"
    }
    @IBAction func usButtonClicked(_ sender: UIButton) {
        fetchUsNews()
        navigationItem.title = "US News"
    }
    @IBAction func scienceButtonClicked(_ sender: UIButton) {
        fetchScienceNews()
        navigationItem.title = "Science News"
    }

    
    fileprivate func fetchHomeNews() {
       // self.showLoading()
        service.fetchHomeNews { [weak self] response in
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
    fileprivate func fetchWorldNews() {
       // self.showLoading()
        service.fetchWorldNews { [weak self] response in
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
    fileprivate func fetchScienceNews() {
       // self.showLoading()
        service.fetchScienceNews { [weak self] response in
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
    fileprivate func fetchUsNews() {
       // self.showLoading()
        service.fetchUsNews { [weak self] response in
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
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let news = self.news[indexPath.row]
     cell.configure(news: news)
//        if news.isValid //&& !news.title!.isEmpty && !news.abstract!.isEmpty && ((news.multimedia?.first?.url?.isEmpty) != nil)
//        {
//             cell.configure(news: news)
//         } else {
//             cell.isHidden = true
//         }
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
            return 150.0 // normal hücre yüksekliği
        } else {
            return 0.0 // boş hücre için sıfır yükseklik
        }
    }
}



