//
//  TopicTableViewCell.swift
//  AssignmentSwift
//
//  Created by vijay on 7/31/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//

import UIKit
protocol TabaleViewCellDelegate {
    func topicSlected(_ name: String)
}
class TopicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topicName: UILabel!
    var cellDelegate:TabaleViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor  = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
    }
    
    @IBAction func onTopicSelected(_ sender: Any) {
        cellDelegate.topicSlected(self.topicName.text!)
    }
    
}
