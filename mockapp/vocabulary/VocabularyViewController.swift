//
//  VocabularyViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/9/23.
//


    import UIKit

    class VocabularyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
       
        

        @IBOutlet weak var tableview: UITableView!
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return vocabList.count
        }
        
        var i = 0;
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // dequeReusbale enables us to reuse table with Id "UseAgain" and saves memory
            let cell = tableView.dequeueReusableCell(withIdentifier: "UseAgain", for: indexPath)
            
            cell.textLabel?.text = vocabList[i].description
            i += 1
            cell.backgroundColor = UIColor.yellow
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
            if let obj = storyboard?.instantiateViewController(withIdentifier: "VocabController") as? VocabController{
                self.navigationController?.pushViewController(obj, animated: true)
            }
           
                
        }
        
        
        let vocabList : [String] = [ "Animal", "Vegetables","Days","Colors","Nature","Vegetables","Body Parts", "Countries","School","Kitchen"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableview.dataSource = self
            tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UseAgain")
            
        }
       
        
        
       
    }
 
