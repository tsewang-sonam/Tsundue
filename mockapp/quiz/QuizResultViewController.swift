//
//  QuizResultViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 1/8/24.
//

import UIKit

class QuizResultViewController: UIViewController {
    
    var forwardedElement: Int?
    var forwardedTableName: String?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let forwardedElement = forwardedElement else { return }
        guard let forwardedTableName = forwardedTableName else { return }
        
        TotalPoint.text = "\(forwardedElement) / 10 "
    }
    
    @IBOutlet weak var TotalPoint: UILabel!

    
    @IBAction func RetryBtn(_ sender: UIButton) {
        let passName = forwardedTableName
        let forwardFromQuiz = self.storyboard?.instantiateViewController(withIdentifier: "QuizImplementViewController") as! QuizImplementViewController
        forwardFromQuiz.passName = passName
        self.navigationController?.pushViewController( forwardFromQuiz, animated: true)
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
    }
    @IBAction func ContinueBtn(_ sender: Any) {
        let back = self.storyboard?.instantiateViewController(withIdentifier: "QuizTableViewController") as! QuizTableViewController
        self.navigationController?.pushViewController( back, animated: true)
        
    }
    
}
