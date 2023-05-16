//
//  StoryTableViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import CoreData

class StoryTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var lenght = "short"
    
    var cellName = ""

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    let storiesTitles : [String] = [ "Story_1","Story_2","Story_3","Story_4","Story_5",
                                       "Story_6","Story_7","Story_8","Story_9","Story_10",]

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
                   let cellTitle = selectedCell?.textLabel?.text ?? ""
                     cellName = lenght + cellTitle
        if let vcE = storyboard?.instantiateViewController(withIdentifier: "ReadStoryViewController") as? ReadStoryViewController{
            vcE.cellName = cellName
            self.navigationController?.pushViewController(vcE, animated: true)
        }
            
    }
    
    
    var i = 0
        //let instanceOfRead = ReadStoryViewController()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        //get the title of story from the array "storiesTitles"
        let cell = UITableViewCell()
        cell.textLabel?.text = storiesTitles[i].description
        i += 1
        
       
               
               //set UIImageView instance that allow us to have use desired image in the cell
               let img = UIImageView()//frame: CGRect(x: 350, y: 5, width: 30, height: 40 ))
              
        let wordForCore = lenght+(cell.textLabel?.text ?? "")
            let instanceOfRead = ReadStoryViewController()
            let resultString = instanceOfRead.fetch(string: wordForCore)
       // print((resultString ?? "sfas") + "hello")
            
       
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        if resultString == "true" {
            img.image = UIImage(named: "medal") }
        else {
            img.image = UIImage(named: "medalBack")
        }
               cell.contentView.addSubview(img)
               
               img.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
               img.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5).isActive = true
               img.widthAnchor.constraint(equalToConstant: 30).isActive = true
               img.heightAnchor.constraint(equalToConstant: 40).isActive = true
               
               
               
           
               return cell

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesTitles.count
    }
    
   
   
}
