//
//  StoryTableViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import CoreData

class StoryTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    // lenght store the name passed from short,moderate and long buttons
    var StoryLength = ""
    
    var cellName = ""
    
    var forwardedWord: String?

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableview.dataSource = self
        tableview.delegate = self
        
        // retrieving the name passed
        guard let forwardedWord = forwardedWord else { return }
        StoryLength = forwardedWord
        
        navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(title: " Back", style: .plain, target: self, action: #selector(backButtonTapped))
           navigationItem.leftBarButtonItem = backButton
       }

       @objc func backButtonTapped() {
           if let targetViewController = navigationController?.viewControllers.first(where: { $0 is StoryViewController }) {
               navigationController?.popToViewController(targetViewController, animated: true)
           }
        
      
    }
    
    // names for the Tables
    let storiesTitles : [String] = [ "Story_1","Story_2","Story_3","Story_4","Story_5"]

    
    // Again here we are passing cellName to next class for easier naming down the line.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let cellTitle = selectedCell?.textLabel?.text ?? ""
            cellName = StoryLength + cellTitle
        
        if let vcE = storyboard?.instantiateViewController(withIdentifier: "ReadStoryViewController") as? ReadStoryViewController{
            vcE.cellName = cellName
            vcE.StoryLength = StoryLength
            self.navigationController?.pushViewController(vcE, animated: true)
        }
            
    }
    
    
    var i = 0
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = UITableViewCell()
        
        //getting the title of story from the array "storiesTitles"
        cell.textLabel?.text = storiesTitles[i].description
        i += 1
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
       
               
        //set UIImageView instance that allow us to have use desired image in the cell
        let img = UIImageView()//frame: CGRect(x: 350, y: 5, width: 30, height: 40 ))
        
        
        // Using wordForCOre , we are fetching data from the CoreData
        let wordForCore = StoryLength+(cell.textLabel?.text ?? "")
            let instanceOfRead = ReadStoryViewController()
            let resultString = instanceOfRead.fetch(string: wordForCore)
       
        
       
        // checking core data and assinging the desired UIimage to the tables
        if resultString == "true" {
            img.image = UIImage(named: "medal") }
        else {
            img.image = UIImage(named: "medalBack")
        }
        
                img.translatesAutoresizingMaskIntoConstraints = false
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
