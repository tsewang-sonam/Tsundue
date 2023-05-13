//
//  QuizViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 5/11/23.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!

    @IBAction func easyPressed(_ sender: Any) {
        
       
        let easyQuiz = self.storyboard?.instantiateViewController(withIdentifier: "QuizTableViewController") as! QuizTableViewController
        self.navigationController?.pushViewController(easyQuiz, animated: true)
        
    }
    @IBAction func moderatePressed(_ sender: Any) {
        
        let moderateQuiz = self.storyboard?.instantiateViewController(withIdentifier: "QuizTableViewController") as! QuizTableViewController
        self.navigationController?.pushViewController(moderateQuiz, animated: true)
    }
    @IBAction func hardPressed(_ sender: Any) {
        
        let hardQuiz = self.storyboard?.instantiateViewController(withIdentifier: "QuizTableViewController") as! QuizTableViewController
        self.navigationController?.pushViewController(hardQuiz, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
