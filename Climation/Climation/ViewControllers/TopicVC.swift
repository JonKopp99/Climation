//
//  TopicVC.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/18/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class TopicVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var headerImage = UIImage()
    var headerTitle = String()
    var tableView = UITableView()
    var topics = [Topic]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("LearnVC")
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backImage.image = #imageLiteral(resourceName: "DSC100373704")
        backImage.alpha = 0.4
        let ga = self.getGradientBackground()
        self.view.addSubview(backImage)
        self.view.layer.insertSublayer(ga, at:0)
        
        dummyData()
        
        let navbar = NavBarHeaderView()
        navbar.headertitle = self.headerTitle
        navbar.shadow = true
        navbar.btnMask = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addChild(navbar)
        self.view.addSubview(navbar.view)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: self.view.bounds.height * 0.1, width: self.view.bounds.width, height: self.view.bounds.height - ( self.view.bounds.height * 0.1))
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        setHeader()
    }
    
    func setHeader()
    {
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.3 + 10))
        
        let backImage = UIImageView()
        backImage.frame = CGRect(x: 5, y: 0, width: self.view.bounds.width - 10, height: self.view.bounds.height * 0.3)
        backImage.image = headerImage
        backImage.layer.cornerRadius = (self.view.bounds.height * 0.3 - 30) * 0.1
        backImage.layer.masksToBounds = true
        backImage.clipsToBounds = true
        backImage.contentMode = .scaleAspectFill
        backImage.alpha = 0.9
        headerview.addSubview(backImage)
        
        tableView.tableHeaderView = headerview
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.bounds.height * 0.3 + 20
    }
    func getGradientBackground()->CAGradientLayer{
        let colorTop = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        return gradientLayer
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        
        return self.view.bounds.height * 0.2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TopicCell()
        cell.selectionStyle = .none
        cell.backImage.image = topics[indexPath.row].backImg
        cell.nameLabel.text = topics[indexPath.row].name
        cell.type = topics[indexPath.row].type!
        cell.time = topics[indexPath.row].time!
        return cell
    }
    
    func dummyData()
    {
        var newTopic = Topic()
        newTopic.name = "Ocean"
        newTopic.backImg = #imageLiteral(resourceName: "ocean")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
        
        newTopic = Topic()
        newTopic.name = "Rain Forest"
        newTopic.backImg = #imageLiteral(resourceName: "RainForest")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
        
        newTopic = Topic()
        newTopic.name = "Wild Life"
        newTopic.backImg = #imageLiteral(resourceName: "WildLife")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
        
        newTopic = Topic()
        newTopic.name = "Regional"
        newTopic.backImg = #imageLiteral(resourceName: "regioncity")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
        
        newTopic = Topic()
        newTopic.name = "Glacier"
        newTopic.backImg = #imageLiteral(resourceName: "iceberg")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
        
        newTopic = Topic()
        newTopic.name = "Other"
        newTopic.backImg = #imageLiteral(resourceName: "otherlightning")
        newTopic.type = "article"
        newTopic.time = 5
        self.topics.append(newTopic)
    }
}

