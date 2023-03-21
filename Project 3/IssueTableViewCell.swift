//
//  IssueTableViewCell.swift
//  Project 3
//
//  Created by Yin-Lin Chen on 2023/1/24.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet var theOpenIssueTitle: UILabel!
    @IBOutlet var theOpenIssueUser: UILabel!
    
    @IBOutlet var theClosedIssueTitle: UILabel!
    @IBOutlet var theClosedIssueUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
