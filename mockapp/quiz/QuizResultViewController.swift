//
//  QuizResultViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 1/8/24.
//

import UIKit
import Lottie

class QuizResultViewController: UIViewController {
    
    var forwardedElement: Int?
    var forwardedTableName: String?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        guard let forwardedElement = forwardedElement else { return }
        guard let forwardedTableName = forwardedTableName else { return }
        
        TotalPoint.text = "\(forwardedElement) / 10 "
        
        lottieAnimation()
    }
    
    
    
    
    @IBOutlet weak var TotalPoint: UILabel!

    @IBOutlet weak var QuizLottie: UIView!
    
    @IBAction func RetryBtn(_ sender: UIButton) {
        let passName = forwardedTableName
        let forwardFromQuiz = self.storyboard?.instantiateViewController(withIdentifier: "QuizImplementViewController") as! QuizImplementViewController
        forwardFromQuiz.passName = passName
        self.navigationController?.pushViewController( forwardFromQuiz, animated: true)
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
        if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }
    }
    @IBAction func ContinueBtn(_ sender: UIButton) {
        let back = self.storyboard?.instantiateViewController(withIdentifier: "QuizTableViewController") as! QuizTableViewController
        self.navigationController?.pushViewController( back, animated: true)
        
    }
    
    func lottieAnimation(){
        
        let animation = LottieAnimationView(name : "vocab")
        animation.translatesAutoresizingMaskIntoConstraints = false
        
        QuizLottie.addSubview(animation)
        
        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: QuizLottie.topAnchor),
            animation.leadingAnchor.constraint(equalTo: QuizLottie.leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: QuizLottie.trailingAnchor),
            animation.bottomAnchor.constraint(equalTo: QuizLottie.bottomAnchor)
        ])
        
        animation.play()
        animation.loopMode = .loop
        
    }
    
}
