//
//  StoryTableViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit

class StoryTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    let storiesTitles : [String] = [ "Story1","Story2","Story3","Story4","Story5",
                                       "Story6","Story7","Story8","Story9","Story10",]

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let selectedCell = tableView.cellForRow(at: indexPath)
                   // let cellName = selectedCell?.textLabel?.text ?? ""
        if let vcE = storyboard?.instantiateViewController(withIdentifier: "ReadStoryViewController") as? ReadStoryViewController{
           // vcE.cellName = cellName
            self.navigationController?.pushViewController(vcE, animated: true)
        }
            
    }
    var i = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
              // let images = img[indexPath.row]
               
               //set UIImageView instance that allow us to have use desired image in the cell
               let img = UIImageView()//frame: CGRect(x: 350, y: 5, width: 30, height: 40 ))
               
               img.translatesAutoresizingMaskIntoConstraints = false
               img.image = UIImage(named: "medal")
               cell.contentView.addSubview(img)
               
               img.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
               img.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5).isActive = true
               img.widthAnchor.constraint(equalToConstant: 30).isActive = true
               img.heightAnchor.constraint(equalToConstant: 40).isActive = true
               
               
               //get the title of story from the array "storiesTitles"
               cell.textLabel?.text = storiesTitles[i].description
               i += 1
           
               return cell

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
   
   
}
