//
//  QuizResultViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 1/8/24.
//

import UIKit

class QuizResultViewController: UIViewController {
    
    var forwardedElement: Int?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        print("It is working now")
        print(forwardedElement!)
    }
    
    @IBOutlet weak var TotalPoint: UILabel!
    
    @IBAction func RetryBtn(_ sender: Any) {
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
    }
    @IBAction func ContinueBtn(_ sender: Any) {
    }
}
