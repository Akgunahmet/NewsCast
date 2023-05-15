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

class NewsDetailsViewController: UIViewController {
    var news : News?
    @IBOutlet weak var newsAbstract: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitle.text = news?.title
        newsAbstract.text = news?.abstract
        if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                   NewsImage.sd_setImage(with: url, placeholderImage: nil)
               }
    }
    
    
    
    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        let titleString = newsTitle.text ?? ""
        UserDefaults.standard.set(titleString, forKey: "title")
        if let media = news?.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            AF.download(url).responseData { response in
                switch response.result {
                case .success(let data):
                    UserDefaults.standard.set(data, forKey: "newsImage")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
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
