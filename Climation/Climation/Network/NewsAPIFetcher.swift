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
    var articles:Articles?
    func getArticles()
    {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=climate_change&from=2019-08-00&to=2019-08-22&language=en&sortBy=popularity&apiKey=2f14afa396d145efb9525f59e93c9c57")!)
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
                let imgLink = checkhttp(str: article.urlToImage!)
                if(imgLink == article.urlToImage)
                {
                 
                   newAr.append(article)
                }else{
                    var newArticle = article
                    newArticle.urlToImage = imgLink
                    newAr.append(newArticle)
                }
                
                
            }
        }
        self.articles?.articles = newAr
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchedNews"), object: nil)

    }
    func checkhttp(str: String)-> String
    {
        if(str.count < 1)
        {
            return str
        }
        
        let firstFive = str.dropLast(str.count - 5)
        if firstFive == "https"
        {
            return str
        }else{
            print("NEWSTRINGTEST: ", "https", str.dropFirst(4))
            return "https\(str.dropFirst(4))"
        }
    }
}

