//
//  File.swift
//  
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation
import Alamofire
import Foundation
import Alamofire

enum Constants: String {
    case baseURL = "https://api.nytimes.com"
    case APIKey = "DpVrv48dISeGawBb396VoAALo3Cj9JiD" // your NYTimes api key here
    case topStories = "/svc/topstories/v2/"
}
    // MARK: Protocol
public protocol NewsServiceProtocol: AnyObject {
    func fetchNews(category: String, completion: @escaping (Result<[News], Error>) -> Void)
    func fetchArtsNews(completion: @escaping (Result<[News], Error>) -> Void)
}

public class NewsService: NewsServiceProtocol {
    public init() {}
    // MARK: Fetch Function
    public func fetchNews(category: String, completion: @escaping (Result<[News], Error>) -> Void) {
        let urlString = Constants.baseURL.rawValue + Constants.topStories.rawValue + category + ".json?api-key=" + Constants.APIKey.rawValue
        
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(NewsResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("********** JSON DECODE ERROR *******")
                }
            case .failure(let error):
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
            }
        }
    }
    
    public func fetchNewsCast(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(category: "home", completion: completion)
    }
    
    public func fetchWorldNews(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(category: "world", completion: completion)
    }
    
    public func fetchArtsNews(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(category: "arts", completion: completion)
    }
    
    public func fetchScienceNews(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(category: "science", completion: completion)
    }
    
    public func fetchUsNews(completion: @escaping (Result<[News], Error>) -> Void) {
        fetchNews(category: "us", completion: completion)
    }
}
