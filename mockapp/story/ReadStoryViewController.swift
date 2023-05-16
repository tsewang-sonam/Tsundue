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
    
    // Following is implementation of next button
    // Where user can press next till the end
    // after which it jump back to the table with other stories options
    
    @IBAction func next(_ sender: Any) {
        count = count + 1
        if( count != 4) {
            
            image.image = UIImage(named: (cellName ?? "") + "pg\(count + 1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 4"
        } else {

                update()
               count = 4
                storyWords.text = "End of Story"
            
                let backToTable = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
                self.navigationController?.pushViewController(backToTable , animated: true)
        }
    }
    
    
    // Following is implementation of prev button
    // it takes the user back to previous page if they desire to read it again
    
    @IBAction func previous(_ sender: Any) {
        if( count != 0) {
            count = count - 1
            image.image = UIImage(named: (cellName ?? "") + "pg\(count + 1)")
            storyWords.text = tenSentences[count].description
            countLabel.text = "Page : " + String(count + 1) + " / 4"
        }else {
                count = 0
            let backToTable2 = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
            self.navigationController?.pushViewController(backToTable2 , animated: true)
        }
    }
    
    @IBOutlet weak var storyWords: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
 
   
        var cellName: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        //cellName get the name of button from previous cell tapped in Viewcontroller
           guard let cellName = cellName else { return }
            
            
            extractFromFile(word: cellName)
            
            //Function add is meant adding the data to the Coredata
            add ()
            
            storyWords.text = tenSentences.first
            countLabel.text = "Page : " + String(count + 1) + " / 4"
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // add the values to the atributes in the core data
        func add () {
            let entity = NSEntityDescription.entity(forEntityName: "StoryTitles", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(cellName, forKey: "id")
            newUser.setValue(false, forKey: "isUserDone")
            
            do {
              try context.save()
             } catch {
              print("Error saving")
            }
        }
        
        


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
        
        // updates the value of the boolean
        func update(){
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StoryTitles")
            fetchRequest.predicate = NSPredicate(format: "id = %@", cellName!)

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



}
