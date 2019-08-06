//
//  NetworkModels.swift
//  Climation
//
//  Created by Jonathan Kopp on 8/6/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
struct Articles: Codable {
    var articles: [ArticleOBJ]
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
}
struct ArticleOBJ: Codable{
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case urlToImage
    }
}
struct MainObj: Codable {
    var temp: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

