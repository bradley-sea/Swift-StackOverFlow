//
//  AnswerSearchViewController.swift
//  SwiftStackOverFlow
//
//  Created by Bradley Johnson on 6/26/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class AnswerSearchViewController: UIViewController, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView : UITableView = nil
    @IBOutlet var searchBar : UISearchBar = nil
    
    var questions = Question[]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // #pragma mark - UISearchBarDelegate
    func searchBarSearchButtonClicked( searchBar: UISearchBar!) {
        searchBar.resignFirstResponder()
        println("\(searchBar.text)")
        
        NetworkController.sharedNetworkController.retrieveQuestionsFor(searchBar.text) {(questions: Question[]) in
            self.questions = questions
            self.tableView.reloadData()
        }

    }
    
    // #pragma mark - UITableViewDataSource
    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.questions.count
    }
    
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        
        let cell = tableView!.dequeueReusableCellWithIdentifier("searchAnswersCell", forIndexPath: indexPath) as QuestionTableViewCell
        let question = self.questions[indexPath!.row]
        cell.textView.text = question.title
        return cell
    }


}
