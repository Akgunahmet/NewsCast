//
//  File 2.swift
//  
//
//  Created by Ahmet Akgün on 11.05.2023.
//

import Foundation

public struct NewsResult: Decodable {
    public let results: [News]?
    public let numResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case numResults = "num_results"
    }
}

public struct News: Decodable {
    public let section: String?
    public let title: String?
    public let abstract: String?
    public let byline: String?
    public let itemType: String?
    public let updatedDate: String?
    public let multimedia: [Media]?
    public let url: String?
    public var isValid: Bool {
        return title != nil || abstract != nil || multimedia?.first != nil
    }
    enum CodingKeys: String, CodingKey {
        case section, title, abstract, byline, multimedia, url
        case itemType = "item_type"
        case updatedDate = "updated_date"
    }
}

public struct Media: Decodable {
    public let url: String?
    public let type: String?
}
