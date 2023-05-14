//
//  QuizTableViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/11/23.
//

import UIKit

class QuizTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabList.count
        
    }
    
    var i = 0;
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "endlessTables", for: indexPath)
        
        cell.textLabel?.text = vocabList[i]
        i += 1
        cell.backgroundColor = UIColor.white
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizObj = self.storyboard?.instantiateViewController(withIdentifier: "QuizImplementViewController") as! QuizImplementViewController
        self.navigationController?.pushViewController(quizObj, animated: true)
       
    }
    
    let vocabList : [String] = [ "Animal", "Vegetables","Days","Colors","Nature","Body_Parts", "Countries","School","Kitchen"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "endlessTables")
    }

}
