//
//  VocabController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/9/23.
//

import UIKit

class VocabController: UIViewController {
    
    var count = 1
    var passName : String?
    var passedWord = ""
    
    
    
    //   getting arrays from the class that stores all the arrays
     let getWordFrom = SearchInFile()
    
    
    @IBAction func prev(_ sender: Any) {
       
        if (count > 1) {
            count = count - 1
            PageNum.text =  count.description
            let currentWord = displayImage()
            getDataFromFile(word : currentWord)
            
        }
        
    }
    @IBAction func next(_ sender: UIButton) {
        
//        let buttonImage = UIImage(named: "square-arrow-2")
//
//               // Set the image for the normal state of the sender button
//               sender.setImage(buttonImage, for: .normal)
//
//               // Adjust the image size to fit the button
//               sender.imageView?.contentMode = .scaleAspectFill
//
//        
        PageNum.text =  count.description
        if (count < 10){
            count = count + 1
            PageNum.text =  count.description
            let currentWord = displayImage()
            getDataFromFile(word : currentWord)
        }else{
            if let navigationController = self.navigationController {
                for viewController in navigationController.viewControllers {
                    
                    if viewController is VocabularyViewController {
                        navigationController.popToViewController(viewController, animated: true)
                        break
                    }
                }
            }
        }
        
    }
    
    
    
    @IBAction func BtnExit(_ sender: UIButton) {
        
        let jumpToTable = self.storyboard?.instantiateViewController(withIdentifier: "VocabularyViewController") as! VocabularyViewController
        
        self.navigationController?.pushViewController(jumpToTable, animated: true)
    }
    
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var learnWord: UILabel!
  //  @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var PageNum: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        PageNum.text = count.description
        passedWord = passName?.lowercased() ?? ""
        let currentWord = displayImage()
        getDataFromFile(word : currentWord)
        
    }
    
    
    
    
   //   getting arrays from the class that stores all the arrays
    let getStringFrom = ArraysOfVocabulary()
    
    
    // This function checks the string and get the desired array from ArraysOfVocabularys method getString from
    // Then the desired array names and images are printed
    func displayImage () -> String {
        
        var word = ""
        
        switch passedWord {
        case "colors" :
           // word = getStringFrom.getTable(named: color)[count].description
            if let wordsArray = getStringFrom.getTable(named: "colors"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
                print(word)
            }
        case "vegetables" :
            if let wordsArray = getStringFrom.getTable(named: "vegetables"),
               wordsArray.indices.contains(count) {
                word = wordsArray[count].description
            }
        case "animal" :
            if let wordsArray = getStringFrom.getTable(named: "animal"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "days" :
            if let wordsArray = getStringFrom.getTable(named: "days"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "nature" :
            if let wordsArray = getStringFrom.getTable(named: "nature"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "countries" :
            if let wordsArray = getStringFrom.getTable(named: "countries"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "school" :
            if let wordsArray = getStringFrom.getTable(named: "school"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "kitchen" :
            if let wordsArray = getStringFrom.getTable(named: "kitchen"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        case "clothes" :
            if let wordsArray = getStringFrom.getTable(named: "clothes"),
               wordsArray.indices.contains(count) {
                 word = wordsArray[count].description
            }
        default :
            return "apple"
        }
        
        let img1 = UIImage(named: word)
        pictures.image = img1
        pictures.contentMode = .scaleAspectFill
        return word
    }
    
    
    
    func getDataFromFile(word: String) {
        
        var keyValue : [String] = []    // array to store values in file
        
        guard let fileUrlDictionary = Bundle.main.path(forResource: "dictionary", ofType: "txt") else {return }
        var readStringDictionary = ""
        do {
            readStringDictionary = try String(contentsOfFile: fileUrlDictionary, encoding: String.Encoding.utf8)
            keyValue = readStringDictionary.components(separatedBy: "\n")    // stores the data in txt to array line by line
            
            var num = 0               // to keep track of array value of the word
            for line in keyValue {
                if !keyValue.isEmpty {
                    let firstWord = line.components(separatedBy: " ").first ?? ""       // retrieving the first word in line
                    if(firstWord.lowercased() == word.lowercased()) {     // checking if userinput and data in txt are same
                        
                        var hi = keyValue[num]
                        if let range = hi.range(of: firstWord) {
                           hi.removeSubrange(range)                  // removing the word and showing the tibetan word
                            print(hi)
                        }
                        englishLabel.text = word
                       learnWord.text = hi
                        return
                    }
                    num += 1
                }
        }

        } catch let error as NSError{
            print("failed to read from Dictionary")
            print(error)
        }
        
       return
    }
    
    

}
