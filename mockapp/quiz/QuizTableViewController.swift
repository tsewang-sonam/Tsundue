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
        
        cell.textLabel?.text = vocabList[i].description
        i += 1
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        
        return cell
        
    }
    
    let vocabList : [String] = [ "Animal", "Vegetables","Colors","Days","Nature","Body_Parts", "Countries","School","Kitchen"]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let passName = vocabList[indexPath.row].description
        if let quizObj = self.storyboard?.instantiateViewController(withIdentifier: "QuizImplementViewController") as? QuizImplementViewController{
            quizObj.passName = passName
            
            self.navigationController?.pushViewController(quizObj, animated: true)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "endlessTables")
        
        let backButton = UIBarButtonItem(title: " Back", style: .plain, target: self, action: #selector(backButtonTapped))
           navigationItem.leftBarButtonItem = backButton
       }

       @objc func backButtonTapped() {
           if let targetViewController = navigationController?.viewControllers.first(where: { $0 is QuizViewController }) {
               navigationController?.popToViewController(targetViewController, animated: true)
           }
        
    }

}
