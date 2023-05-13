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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "endlessTables", for: indexPath)
        
        cell.textLabel?.text = "endlessTables"
        //i += 1
        cell.backgroundColor = UIColor.red
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizObj = self.storyboard?.instantiateViewController(withIdentifier: "QuizImplementViewController") as! QuizImplementViewController
        self.navigationController?.pushViewController(quizObj, animated: true)
       
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "endlessTables")
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
