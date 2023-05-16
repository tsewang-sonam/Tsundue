//
//  StoryViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit

class StoryViewController: UIViewController {
    
    
    // In this class we are trying implement three button that has options of "short, moderate and long " Stories
    // Also we forwarded String as  "short", "medium", "long" to the next class as for easier implementation of naming
    // for the objects in future.   Example :  short + Story_1 + img1 = shortStory1img1

    @IBAction func shortStoryButton(_ sender: Any) {
        let forwardedWord = "short"
        let shortStory = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        shortStory.forwardedWord = forwardedWord
        self.navigationController?.pushViewController(shortStory, animated: true)
    }
    @IBAction func moderateStoryButton(_ sender: Any) {
        let forwardedWord = "moderate"
        let moderateStory = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        moderateStory.forwardedWord = forwardedWord
        self.navigationController?.pushViewController(moderateStory, animated: true)
    }
    @IBAction func longStoryButton(_ sender: Any) {
        let forwardedWord = "long"
        let longStory = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        longStory.forwardedWord = forwardedWord
        self.navigationController?.pushViewController(longStory, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
