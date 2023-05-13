//
//  VocabController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/9/23.
//

import UIKit

class VocabController: UIViewController {
    
    var count = 0
    var passName : String?
    var passedWord = ""
    
    //   getting arrays from the class that stores all the arrays
     let getWordFrom = SearchInFile()
    
    
    @IBAction func prev(_ sender: Any) {
       
        if (count > 0) {
            
           // pageCount.isHidden = false
            count = count - 1
            pageCount.text = "Word : " + count.description
            let currentWord = displayImage()
            getDataFromFile(word : currentWord)
            
        }
        
    }
    @IBAction func next(_ sender: Any) {
        
        pageCount.text = "Word : " + count.description
        if (count < 10){
           // pageCount.isHidden = false
            count = count + 1
            pageCount.text = "Word : " + count.description
            let currentWord = displayImage()
            getDataFromFile(word : currentWord)
        }
        
    }
    @IBOutlet weak var learnWord: UILabel!
    @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var pictures: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCount.text = "Word :  0"
        passedWord = passName?.lowercased() ?? ""
        let currentWord = displayImage()
        getDataFromFile(word : currentWord)
        
    }
    
    
    
    
   //   getting arrays from the class that stores all the arrays
    let getStringFrom = ArraysOfVocabulary()
    
    
    
    func displayImage () -> String {
        
        var word = ""
        
        switch passedWord {
        case "colors" :
             word = getStringFrom.colors[count].description
        case "vegetables" :
             word = getStringFrom.vegetables[count].description
        case "animal" :
            word = getStringFrom.animal[count].description
        case "days" :
            word = getStringFrom.colors[count].description
        case "nature" :
            word = getStringFrom.colors[count].description
        case "countries" :
            word = getStringFrom.colors[count].description
        case "school" :
            word = getStringFrom.colors[count].description
        case "kitchen" :
            word = getStringFrom.colors[count].description
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
                       learnWord.text = word + " : "+hi
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
