//
//  QuizImplementViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/11/23.
//

import UIKit

class QuizImplementViewController: UIViewController {

    
    // To Remember ****
    // Have set the tag fro button from 1 to 4 and it matches with the current answer to check if answer is right.
    
    var passName : String?
    var passedTableName = ""
    
    var count : Int = 0
    var totalPoint : Int =  0
    var currentAnswer : Int = 0
    var selectedButton : Int = 0
    
    var one1 = 0, two2 = 0, three3 = 0, four4 = 0
   
    var mySet: Set<Int> = [0,1,2,3,4,5,6,7,8,9,10]
    var storeNum : [Int] = []
        
    let getStringFrom = ArraysOfVocabulary()
        
        
        
    struct RandomNumberGenerator {
            static func RandomNum() -> (Int, Int, Int, Int) {
                var fourRandomNum = Array(0...10) // range of the numbers of question
                fourRandomNum.shuffle()
                
                let (first, second, third, fourth) = (
                    fourRandomNum[0],
                    fourRandomNum[1],
                    fourRandomNum[2],
                    fourRandomNum[3]
                )
                
                return (first, second, third, fourth)
            }
        }
    
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    // array of UIbutton
    var buttons: [UIButton] = []
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    @IBOutlet weak var quizWord: UILabel!
    
    @IBOutlet weak var scoreCount: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
          scoreCount.text =  "\(totalPoint)/ 10"
          refreshQuiz()
       
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
       
        scoreCount.text = "\(totalPoint)/ 10"
        
        if(count < 9){
            
            if(currentAnswer == selectedButton ){
                totalPoint += 1
            }
            
            count += 1
            viewDidLoad()
        }
        else{
            let forwardedElement = totalPoint
            let forwardedTableName = passName
            let numberSend = self.storyboard?.instantiateViewController(withIdentifier: "QuizResultViewController") as! QuizResultViewController
            numberSend.forwardedElement = forwardedElement
            self.navigationController?.pushViewController( numberSend, animated: true)
            
        }
        
    }
    
   
    func refreshQuiz() {
     (one1, two2, three3, four4) = RandomNumberGenerator.RandomNum()
        passedTableName = passName?.lowercased() ?? ""
        displayImage(passedTableName: passedTableName)

        buttons = [btn1, btn2, btn3, btn4]

           for button in buttons {
               button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
           }
    }

    
    
    
    // This function display four random images on four distinct UIimage
    func displayImage (passedTableName : String) {

    
    var word1 = ""
        if let wordsArray = getStringFrom.getTable(named: passedTableName),
                   wordsArray.indices.contains(one1) {
                     word1 = wordsArray[one1]
                } else {
                    print("Invalid table name or index")
                }
    let boxImg1 = UIImage(named: word1)
    img1.image = boxImg1
    img1.contentMode = .scaleAspectFill

        
    var word2 = ""
        if let wordsArray = getStringFrom.getTable(named: passedTableName),
                       wordsArray.indices.contains(two2) {
                         word2 = wordsArray[two2]
                    } else {
                        print("Invalid table name or index")
                    }
    let boxImg2 = UIImage(named: word2)
    img2.image = boxImg2
    img2.contentMode = .scaleAspectFill

    var word3 = ""
        if let wordsArray = getStringFrom.getTable(named: passedTableName),
                       wordsArray.indices.contains(three3) {
                         word3 = wordsArray[three3]
                       
                    } else {
                        print("Invalid table name or index")
                    }
    let boxImg3 = UIImage(named: word3)
    img3.image = boxImg3
    img3.contentMode = .scaleAspectFill

        
    var word4 = ""
        if let wordsArray = getStringFrom.getTable(named: passedTableName),
           wordsArray.indices.contains(four4) {
            word4 = wordsArray[four4]
            
            } else {
                    print("Invalid table name or index")
                    }
    let boxImg4 = UIImage(named: word4)
    img4.image = boxImg4
    img4.contentMode = .scaleAspectFill

       
        let getOneRandom = Int(arc4random_uniform(UInt32(4))) + 1    //getting a random pick from 4 possible selection
        currentAnswer = getOneRandom


        switch getOneRandom {
        case 1:
            getDataFromFile(word: word1)
        case 2:
            getDataFromFile(word: word2)
        case 3:
            getDataFromFile(word: word3)
        case 4:
            getDataFromFile(word: word4)
        default:
            print("nothing to print")

        }

        
    }
    
    // checks which of the four button is pressed
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        clearSelectedState()
        sender.isSelected = true
        selectedButton = sender.tag
        sender.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        
    }

        // Makes the background clear for the button not selected
    func clearSelectedState() {
        buttons.forEach {
            $0.isSelected = false
            $0.backgroundColor = UIColor.clear
        }
    }
    
    
    
    
    
    func getDataFromFile(word: String) -> Bool {
        
        print (" In txt " + word)
        var keyValue : [String] = []    // array to store values in file
        
        guard let fileUrlDictionary = Bundle.main.path(forResource: "dictionary", ofType: "txt") else {return false}
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
                        quizWord.text = hi
                        return true
                    }
                    num += 1
                }
              
        }

        } catch let error as NSError{
            print("failed to read from Dictionary")
            print(error)
        }
        
       return false
    }
    
    
    
}
