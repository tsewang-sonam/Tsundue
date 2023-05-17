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
            
            cell.textLabel?.text = vocabList[i]
            i += 1
            cell.backgroundColor = UIColor.white
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
            let passName = vocabList[indexPath.row].description
            if let obj = storyboard?.instantiateViewController(withIdentifier: "VocabController") as? VocabController{
                obj.passName = passName
                self.navigationController?.pushViewController(obj, animated: true)
            }
           
                
        }
        
        
        let vocabList : [String] = [ "Animal", "Vegetables","Colors","Days","Nature","Body_Parts", "Countries","School","Kitchen"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UseAgain")
            
        }
       
        
        
       
    }
 
