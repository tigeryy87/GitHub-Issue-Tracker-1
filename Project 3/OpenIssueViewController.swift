//
//  OpenIssueViewController.swift
//  Project 3
//
//  Created by Yin-Lin Chen on 2023/1/24.
//

import UIKit

struct Issue: Codable {
    let title: String
    let createdAt: String
    let body: String
    let user: String
}

class OpenIssueViewController: UITableViewController {

    
    var openIssues: [Issue] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pull to refresh
        let refreshControl = UIRefreshControl()
        let refreshTitle = NSAttributedString(string: "Pull to refresh open issues.")
        refreshControl.attributedTitle = refreshTitle
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        // Customize the color of UINavigationBar
        // reference: https://developer.apple.com/documentation/uikit/uinavigationcontroller/customizing_your_app_s_navigation_bar
        let navBar = self.navigationController!.navigationBar
        let openIssueAppearance = UINavigationBarAppearance()
        openIssueAppearance.backgroundColor = UIColor.systemRed
        navBar.scrollEdgeAppearance = openIssueAppearance
        
        // Fetch data
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"


        GitHubClient.fetchIssues(
            state: "open",
            completion: {(issues, error) in
                // Ensure we have good data before anything else
                guard let issues = issues, error == nil else {
                    print(error!)
                    return
                }
                // Date formating
                for issue in issues {
                    // Parse the data in issues to extract the information needed
                    // reference: https://stackoverflow.com/questions/35700281/date-format-in-swift
                    if let title = issue.title, let body = issue.body,
                       let date = dateFormatterGet.date(from: issue.createdAt) {
                        self.openIssues.append(Issue(title: title, createdAt: dateFormatterPrint.string(from: date), body: body, user: "@"+issue.user.login))
                    }
                }
                self.tableView.reloadData()
            }
        )
    }

    @objc func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return openIssues.count
    }
    
    // https://stackoverflow.com/questions/24471954/how-to-use-dequeuereusablecellwithidentifier-in-swift
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenCell", for: indexPath) as! IssueTableViewCell
        // Configure the cell
        cell.theOpenIssueTitle.text = openIssues[indexPath.row].title
        cell.theOpenIssueUser.text =  openIssues[indexPath.row].user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! IssueDetailViewController
            detailVC.passInData = openIssues[indexPath.row]
            detailVC.issueType = "open"
        }
    }
}
