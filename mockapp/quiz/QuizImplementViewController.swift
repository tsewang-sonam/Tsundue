//
//  QuizImplementViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/11/23.
//

import UIKit

class QuizImplementViewController: UIViewController {

    
    var count = 0
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var quizWord: UILabel!
    
    @IBOutlet weak var scoreCount: UILabel!
    
    @IBAction func submitPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        num.shuffle()
         displayImage()
        // Do any additional setup after loading the view.
    }
    
    static var fourRandomNum : [Int] = [2,6,1,5]
    var num : [Int] = [0,1,2,3,4,5,6,7,8,9,10]
   
    var temp : [Int] = []

    var k = 0
    
   let firstRandom = fourRandomNum[0]
    
    var j = 0
    
    
    
    let getStringFrom = ArraysOfVocabulary()
    
    func displayImage () -> String {
        
        while j < 4 {
            
            let randomNum  =  num[j]
            
            
            if temp.contains(randomNum) {
                j -= 1
            }else {
                QuizImplementViewController.fourRandomNum[j] = randomNum
            }
            j += 1
        }
        
        print( QuizImplementViewController.fourRandomNum[0])
        print( QuizImplementViewController.fourRandomNum[1])
        print( QuizImplementViewController.fourRandomNum[2])
        print( QuizImplementViewController.fourRandomNum[3])
        
        var one = QuizImplementViewController.fourRandomNum[0]
        var two =  QuizImplementViewController.fourRandomNum[1]
        var three =  QuizImplementViewController.fourRandomNum[2]
        var four =  QuizImplementViewController.fourRandomNum[3]
        
    
        
        
    let word1 = getStringFrom.vegetables[one].description
        quizWord.text = word1
    let boxImg1 = UIImage(named: word1)
    img1.image = boxImg1
    img1.contentMode = .scaleAspectFill
    
        
    let word2 = getStringFrom.vegetables[two].description
    let boxImg2 = UIImage(named: word2)
    img2.image = boxImg2
    img2.contentMode = .scaleAspectFill
        
    let word3 = getStringFrom.vegetables[three].description
    let boxImg3 = UIImage(named: word3)
    img3.image = boxImg3
    img3.contentMode = .scaleAspectFill
        
    let word4 = getStringFrom.vegetables[four].description
    let boxImg4 = UIImage(named: word4)
    img4.image = boxImg4
    img4.contentMode = .scaleAspectFill

    return word1
        
    }
}
