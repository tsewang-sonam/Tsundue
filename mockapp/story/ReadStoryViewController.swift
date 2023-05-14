//
//  ReadStoryViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import CoreData

class ReadStoryViewController: UIViewController {
    var count = 0
    
    @IBAction func next(_ sender: Any) {
        count = count + 1
        if( count != 4) {
            
            image.image = UIImage(named: "pg\(count + 1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 4"
        } else {
            do {
             //  animationLottie()
                storyWords.text = "End of Story"
                count = 4
            }
        }
    }
    @IBAction func previous(_ sender: Any) {
        if( count != 0) {
            count = count - 1
            image.image = UIImage(named: "pg\(count+1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 4"
        }else {
            do {
                //   animationLottie()
                count = 0
            }
        }
        
    }
    @IBOutlet weak var storyWords: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   // var item : [ShortStory]?
   
       // var cellName: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // cellName get the name of button from previous cell tapped in Viewcontroller
           // guard let cellName = cellName else { return }
            
            // Do any additional setup after loading the view.
            extractFromFile(word: "Story1")
            storyWords.text = tenSentences.first
            countLabel.text = "Page : " + String(count + 1) + " / 4"
           // storyWords.text = "heeeee"
            image.image = UIImage(named: "pg1")
            image.contentMode = .scaleAspectFill
        }
        
        
    var tenSentences : [String] = []
        
    func  extractFromFile (word : String)  {
            
            guard let path = Bundle.main.url(forResource: "Story", withExtension: "txt") else { return }
            
            do {
                let fileContents = try String(contentsOf: path, encoding: .utf8)
                let lines = fileContents.components(separatedBy: "\n")
                
                for (index, line) in lines.enumerated() {
                    
                    
                   // let storeBool = ShortStory(context: self.context)
                    
                    if line.contains(word) {
                        // Found the search word, add the next 4 lines to the array
                        for i in 1...4 {
                            if index + i < lines.count {
                                tenSentences.append(lines[index + i])
                            }
                        }
                        break // Stop searching after finding the first occurrence
                    }
                }
                
                // Print the following lines
                for line in tenSentences {
                    print(line)
                }
                
            } catch {
                print("Error reading file: \(error)")
            }
        }


}
