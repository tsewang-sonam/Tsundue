//
//  searchInFile.swift
//  mockapp
//
//  Created by tsewang sonam on 5/12/23.
//

import UIKit

class SearchInFile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getDataFromFile(word: String) -> String {
        
        var keyValue : [String] = []    // array to store values in file
        var word = ""
        
        guard let fileUrlDictionary = Bundle.main.path(forResource: "dictionary", ofType: "txt") else {return "false"}
        var readStringDictionary = ""
        do {
            readStringDictionary = try String(contentsOfFile: fileUrlDictionary, encoding: String.Encoding.utf8)
            keyValue = readStringDictionary.components(separatedBy: "\n")    // stores the data in txt to array line by line
            
            var num = 0               // to keep track of array value of the word
            for line in keyValue {
                if !keyValue.isEmpty {
                    let firstWord = line.components(separatedBy: " ").first ?? ""       // retrieving the first word in line
                    if(firstWord.lowercased() == word.lowercased()) {     // checking if userinput and data in txt are same
                        
                        print("hfalksdaklsfls")
                        var hi = keyValue[num]
                        if let range = hi.range(of: firstWord) {
                           hi.removeSubrange(range)                  // removing the word and showing the tibetan word
                            print(hi + "aaaaaaa")
                        }
                       word = hi
                        print(hi + "hi")
                        print(word + "here")
                        return hi
                    }
                    num += 1
                }
              
        }

        } catch let error as NSError{
            print("failed to read from Dictionary")
            print(error)
        }
        
        
       return word
    }

}
