//
//  ReadStoryViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import CoreData

class ReadStoryViewController: UIViewController {
    
    var cellName: String?
    var StoryLength : String?
    
    var count = 0
    
    // Following is implementation of next button
    // Where user can press next till the end
    // after which it jump back to the table with other stories options
    
    @IBAction func next(_ sender: Any) {
        count = count + 1
        if( count != 17) {
            
            image.image = UIImage(named: (cellName ?? "") + "pg\(count + 1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 17"
        } else {

                update()
               count = 17
            let forwardLengthName = StoryLength
                let jumpToEnd = self.storyboard?.instantiateViewController(withIdentifier: "StoryEndViewController") as! StoryEndViewController
                jumpToEnd.StoryLength = forwardLengthName
                self.navigationController?.pushViewController(jumpToEnd , animated: true)
        }
    }
    
    
    // Following is implementation of prev button
    // it takes the user back to previous page if they desire to read it again
    
    @IBAction func previous(_ sender: Any) {
        if( count != 0) {
            count = count - 1
            image.image = UIImage(named: (cellName ?? "") + "pg\(count + 1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 17"
        }else {
                count = 0
        }
    }
    
    @IBOutlet weak var storyWords: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func exitBtn(_ sender: UIButton) {
        
        let forwardedWord = StoryLength
            let jumpToTabel = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        
        jumpToTabel.forwardedWord = forwardedWord
            self.navigationController?.pushViewController(jumpToTabel , animated: true)
    }
    
   
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.hidesBackButton = true
            
        //cellName get the name of button from previous cell tapped in Viewcontroller And also we get the length of story (eg. short, long etc)
           guard let cellName = cellName else { return }
            guard let StoryLength = StoryLength else { return }
            
            extractFromFile(word: cellName)
            
            //Function add is meant adding the data to the Coredata
            add ()
            
            print(StoryLength);
          updateLabelWithSentence()
          //  updateWithSentence()
            
            storyWords.text = " "
          //  countLabel.text = "Page : " + String(count + 1) + " / 12"
            image.image = UIImage(named: (cellName ) + "pg\(count + 1)")
            image.contentMode = .scaleAspectFill
        }
        
    // Stores the sentences from the Story txt
    var tenSentences : [String] = []
        
    
    // This Function 
    func  extractFromFile (word : String)  {
            
            guard let path = Bundle.main.url(forResource: "Story", withExtension: "txt") else { return }
            
            do {
                let fileContents = try String(contentsOf: path, encoding: .utf8)
                let lines = fileContents.components(separatedBy: "\n")
                
                for (index, line) in lines.enumerated() {
                    
                    
                   // let storeBool = ShortStory(context: self.context)
                    if line.contains(word) {
                        // Found the search word, add the next 17 lines to the array
                        for i in 1...17 {
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    
    // This FUnction adds the values to the atributes in the core data
    func add () {
            let entity = NSEntityDescription.entity(forEntityName: "StoryTitles", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
        //print(cellName)
            newUser.setValue(cellName, forKey: "id")
            newUser.setValue(false, forKey: "isUserDone")
            
            do {
              try context.save()
             } catch {
              print("Error saving")
            }
        }
        
        

    // This FUnction fetchs String values from the core data
    func fetch(string: String) -> String? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StoryTitles")
        request.predicate = NSPredicate(format: "id = %@", string)
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let isUserDone = data.value(forKey: "isUserDone") as? Bool {
                    let resultString = isUserDone ? "true" : "false"
                    return resultString
                } else {
                    return nil
                }
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
        return nil
    }
        
        // THIs function updates the value of the boolean in the core data
        func update(){
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StoryTitles")
            fetchRequest.predicate = NSPredicate(format: "id = %@", cellName!)
            print("cellName:", cellName)
            do {
                let result = try context.fetch(fetchRequest)
               
                if let user = result.first as? NSManagedObject {
                    user.setValue(true, forKey: "isUserDone")
                    try context.save()
                    print("Successfully updated boolean value")
                } else {
                    print("bool not found")
                }
            } catch let error as NSError {
                print("Fetch error: \(error), \(error.userInfo)")
            }
        }
    
    

    
    func updateLabelWithSentence() {
        print(tenSentences.count)
        let sentence = tenSentences[count]
        
        // Set different font sizes for different sentences
        var fontSize: CGFloat
        switch StoryLength {
        case "short":
            fontSize = 25.0
        case "moderate":
            fontSize = 20.0
        case "long":
            fontSize = 15.0
        default:
            fontSize = 10.0
        }
        
        // Get the size of the screen
        let screenSize = UIScreen.main.bounds.size
        
        // Calculate a factor based on screen size
        let screenFactor = min(screenSize.width, screenSize.height) / 375.0 // Assuming a reference width of 375
        
        // Adjust font size based on screen size
        if screenFactor < 1.0 {
            fontSize *= 0.8 // Reduce font size for smaller screens
        } else if screenFactor > 1.0 {
            fontSize *= screenFactor // Increase font size for larger screens
        }
        
        let attributedString = NSAttributedString(
            string: sentence,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        )
        
        storyWords.attributedText = attributedString
    }
}
