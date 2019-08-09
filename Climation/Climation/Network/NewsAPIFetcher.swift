//
//  NewsAPIFetcher.swift
//  Climation
//
//  Created by Jonathan Kopp on 8/6/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class NewsAPIFetcher
{
    var str = "Hello, playground"
    var articles:Articles?
    func getArticles()
    {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=climate_change&from=2019-07-07&sortBy=publishedAt&apiKey=2f14afa396d145efb9525f59e93c9c57")!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            guard let data = data else {
                print("Contains No Data")
                return
            }
            DispatchQueue.main.async {
                let object = try! JSONDecoder().decode(Articles.self, from: data)
                self.articles = object
                //print("ARTICLES DOWNLOADED: ", self.articles?.articles.count)
                self.filterNoPicture()
            }
            
        }
        dataTask.resume()
        }
    func filterNoPicture()
    {
        var newAr = [ArticleOBJ]()
        for article in self.articles!.articles
        {
            if article.urlToImage != nil
            {
                newAr.append(article)
            }
        }
        self.articles?.articles = newAr
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchedNews"), object: nil)

    }
    func checkhttp(str: String)-> String
    {
       // let firstFive = //
//        if firstFive == "https"
//        {
//            return str
//        }
        return ""
    }
}

