//
//  File.swift
//  
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation
import Alamofire

public protocol PopularMovieServiceProtocol: AnyObject {
    func fetchPopularMovies(completion: @escaping (Result<[News], Error>) -> Void)
}


public class PopularMovieService: PopularMovieServiceProtocol {
    
    public init() {}
    
    public func fetchPopularMovies(completion: @escaping (Result<[News], Error>) -> Void) {
        
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=DpVrv48dISeGawBb396VoAALo3Cj9JiD"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(PopularMovieResponse.self, from: data)
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
