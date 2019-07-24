//
//  ViewController.swift
//  Climation
//
//  Created by Jonathan Kopp on 7/16/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class LearnVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var hasAnimated = Bool()
    var tableView = UITableView()
    var topics = [HomeTopic]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var bottom = self.view.safeAreaInsets.bottom
        if bottom == 0
        {
            bottom = 10
        }
        tableView.frame = CGRect(x: 0, y: self.view.bounds.height * 0.1, width: self.view.bounds.width, height: self.view.bounds.height - (50 + bottom + (self.view.bounds.height * 0.1)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LearnVC")
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backImage.image = #imageLiteral(resourceName: "DSC100373704")
        backImage.alpha = 0.4

        let ga = self.getGradientBackground()
        self.view.addSubview(backImage)
        self.view.layer.insertSublayer(ga, at:0)
        
        createNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dummyData()
        hasAnimated = false
        self.tableView.reloadData()
    }
    
    func createNavBar()
    {
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * 0.1))
        navView.backgroundColor = .clear
        navView.isOpaque = true
        
        let label = UILabel(frame: CGRect(x:0, y: navView.bounds.height/2-10, width: navView.bounds.width, height: 50))
        label.text = "Learn"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: -2, height: 2)
        
        navView.addSubview(label)
        
        let settingsButton = UIButton(frame: CGRect(x: self.view.bounds.width - 30, y: label.frame.minY + 15, width: 20, height: 20))
        settingsButton.setImage(#imageLiteral(resourceName: "icons8-settings-50 (2)").mask(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), for: .normal)
        navView.addSubview(settingsButton)
        settingsButton.addTarget(self, action:#selector(self.settingsPressed), for: .touchUpInside)

        self.view.addSubview(navView)
    }

    @objc func settingsPressed()
    {
        print("Settings Pressed")
        let vc = SettingsVC()
        let animation = CATransition()
        animation.type = .push
        animation.subtype = .fromTop
        animation.duration = 0.3
        self.view.window!.layer.add(animation, forKey: nil)
        
        self.present(vc, animated: false, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeCell
        print(cell.nameLabel.text!)
        let vc = TopicVC()
        vc.headerImage = cell.backImage.image!
        vc.headerTitle = cell.nameLabel.text!
        let animation = CATransition()
        animation.type = .push
        animation.subtype = .fromTop
        animation.duration = 0.3
        self.view.window!.layer.add(animation, forKey: nil)
        
        
        self.present(vc, animated: false, completion: nil)
   
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell()
        cell.selectionStyle = .none
        cell.backImage.image = topics[indexPath.row].backImg
        cell.nameLabel.text = topics[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! HomeCell
        if(hasAnimated){return}
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        cell.backImage.alpha = 0.2
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.backImage.alpha = 0.8
        })
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == topics.count - 1)
        {
            hasAnimated = true
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        topics = [HomeTopic]()
        tableView.reloadData()
    }
    
    func dummyData()
    {
        var newTopic = HomeTopic()
        newTopic.name = "Ocean"
        newTopic.backImg = #imageLiteral(resourceName: "ocean")
        self.topics.append(newTopic)
        
        newTopic = HomeTopic()
        newTopic.name = "Rain Forest"
        newTopic.backImg = #imageLiteral(resourceName: "RainForest")
        self.topics.append(newTopic)
        
        newTopic = HomeTopic()
        newTopic.name = "Wild Life"
        newTopic.backImg = #imageLiteral(resourceName: "WildLife")
        self.topics.append(newTopic)
        
        newTopic = HomeTopic()
        newTopic.name = "Regional"
        newTopic.backImg = #imageLiteral(resourceName: "regioncity")
        self.topics.append(newTopic)
        
        newTopic = HomeTopic()
        newTopic.name = "Glacier"
        newTopic.backImg = #imageLiteral(resourceName: "iceberg")
        self.topics.append(newTopic)
        
        newTopic = HomeTopic()
        newTopic.name = "Other"
        newTopic.backImg = #imageLiteral(resourceName: "otherlightning")
        self.topics.append(newTopic)
    }
}

