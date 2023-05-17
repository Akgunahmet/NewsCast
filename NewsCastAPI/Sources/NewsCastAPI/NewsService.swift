//
//  File.swift
//  
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation
import Alamofire
enum Constants: String {
    case baseURL = "https://api.nytimes.com"
    case APIKey = "DpVrv48dISeGawBb396VoAALo3Cj9JiD"
    case home = "/svc/topstories/v2/home.json?api-key="
    case arts = "/svc/topstories/v2/arts.json?api-key="
    case us = "/svc/topstories/v2/us.json?api-key="
    case science = "/svc/topstories/v2/science.json?api-key="
    case world = "/svc/topstories/v2/world.json?api-key="
}
public protocol NewsServiceProtocol: AnyObject {
    func fetchNewsCast(completion: @escaping (Result<[News], Error>) -> Void)
   func fetchWorldNews(completion: @escaping (Result<[News], Error>) -> Void)
   func fetchArtsNews(completion: @escaping (Result<[News], Error>) -> Void)
   func fetchScienceNews(completion: @escaping (Result<[News], Error>) -> Void)
   func fetchUsNews(completion: @escaping (Result<[News], Error>) -> Void)
}


public class NewsService: NewsServiceProtocol {
    
    public init() {}
    
    public func fetchNewsCast(completion: @escaping (Result<[News], Error>) -> Void) {
        
        let urlString = Constants.baseURL.rawValue + Constants.home.rawValue + Constants.APIKey.rawValue
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
    public func fetchWorldNews(completion: @escaping (Result<[News], Error>) -> Void) {
        
        let urlString = Constants.baseURL.rawValue + Constants.world.rawValue + Constants.APIKey.rawValue
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
    public func fetchArtsNews(completion: @escaping (Result<[News], Error>) -> Void) {
        
        let urlString = Constants.baseURL.rawValue + Constants.arts.rawValue + Constants.APIKey.rawValue
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
    public func fetchScienceNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let urlString = Constants.baseURL.rawValue + Constants.science.rawValue + Constants.APIKey.rawValue
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
    public func fetchUsNews(completion: @escaping (Result<[News], Error>) -> Void) {
        
        let urlString = Constants.baseURL.rawValue + Constants.us.rawValue + Constants.APIKey.rawValue
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
}
