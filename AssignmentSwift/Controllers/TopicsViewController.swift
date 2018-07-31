//
//  TopicsViewController.swift
//  AssignmentSwift
//
//  Created by vijay on 7/31/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//

import UIKit

let kRowHight = 100

class TopicsViewController: UIViewController, TabaleViewCellDelegate {
    let cellID = "TopicTableViewCell"
    @IBOutlet weak var topicsTableView: UITableView!
    
    
    let Topics = ["Fiction","Drama","Humor","Politics","Philosophy","History","adventure"];

    override func viewDidLoad() {
        super.viewDidLoad()
        topicsTableView.register(UINib.init(nibName:cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.topicsTableView.backgroundColor = UIColor.clear
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -  TabaleViewCellDelegate methods
    func topicSlected(_ name: String) {
        let booksController = ViewController()
        booksController.backButtonText = name
        self.navigationController?.pushViewController(booksController, animated: true)
    }
}

 //MARK: - TableView datasource and delegate methods
extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopicTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TopicTableViewCell
        cell.topicName.text = self.Topics[indexPath.row].uppercased()
        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = Topics[indexPath.row]
        topicSlected(topic)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(kRowHight)
    }
}
