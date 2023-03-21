//
//  IssueDetailViewController.swift
//  Project 3
//
//  Created by Yin-Lin Chen on 2023/1/24.
//

import UIKit

class IssueDetailViewController: UIViewController {

    var passInData: Issue?
    var issueType: String?
    @IBOutlet var theTitle: UILabel!
    @IBOutlet var theAuthor: UILabel!
    @IBOutlet var theDate: UILabel!
    @IBOutlet var theImage: UIImageView!
    @IBOutlet var theDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        theTitle.text = passInData?.title
        theAuthor.text = passInData?.user
        theDate.text = passInData?.createdAt
        theDescription.text = passInData?.body
        if let type = issueType {
            if type == "open" {
                theImage.image = UIImage(systemName: "envelope.open")
                theImage.tintColor = UIColor.systemOrange
            } else {
                theImage.image = UIImage(systemName: "envelope")
                theImage.tintColor = UIColor.systemGreen
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
