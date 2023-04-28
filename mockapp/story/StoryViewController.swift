//
//  StoryViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit

class StoryViewController: UIViewController {

    @IBAction func shortStoryButton(_ sender: Any) {
        
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    @IBAction func moderateStoryButton(_ sender: Any) {
    }
    @IBAction func longStoryButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
