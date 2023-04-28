//
//  ViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    private var animationView : LottieAnimationView!
    
    @IBOutlet weak var storyLottie: UIView!

    

    
    @IBAction func storyButton(_ sender: Any) {
        lottieAnimation()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
     
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    @IBAction func vocabularyButton(_ sender: Any) {
    }
    
    @IBAction func quizButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func lottieAnimation() {
        
        animationView = .init(name : "113796-alienufo-reading-book-animation")
        animationView.frame = CGRect(x: 30, y: 360, width: 145, height: 130)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()
    }
}

