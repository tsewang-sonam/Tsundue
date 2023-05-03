//
//  ViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/13/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    
    //@IBOutlet weak var storyLottie: UIView!
    
    private var welcomeScreen : LottieAnimationView!
    
    @IBOutlet weak var searchTop: LottieAnimationView!
    
    @IBOutlet weak var storyTop: LottieAnimationView!
    
    @IBOutlet weak var vocabularyTop: LottieAnimationView!
    
    @IBOutlet weak var quizTop: LottieAnimationView!
    
    @IBAction func storyButton(_ sender: UIButton) {
//        let addonTop = UIView()
//          sender.superview?.addSubview(addonTop)
//          sender.superview?.bringSubviewToFront(sender)
          print("clicked")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @IBAction func searchButton(_ sender: UIButton) {

          print("clicked")

    }
    
    @IBAction func vocabularyButton(_ sender: UIButton) {
       
        print("clicked")
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        print("clicked")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // lottieWelcome()
        lottieAnimation(string : "search" , outletButton: searchTop)
       lottieAnimation(string :"read",outletButton: storyTop)
//        
//        let addonTop = UIView()
//        storyTop.superview?.addSubview(addonTop)
//        storyTop.superview?.bringSubviewToFront(storyTop)
        
        lottieAnimation(string :"vocab",outletButton: vocabularyTop)
        lottieAnimation(string :"vocabulary",outletButton: quizTop)
//
    }
    
    func lottieAnimation(string : String, outletButton : LottieAnimationView) {
      
        let animation = LottieAnimation.named(string)
               outletButton.animation = animation
               outletButton.loopMode = .loop
               outletButton.play()

    }
    
    func lottieWelcome() {
        welcomeScreen = .init(name: "welcome")
        welcomeScreen.frame = view.frame
        welcomeScreen.contentMode = .scaleAspectFit
        welcomeScreen.loopMode = .playOnce
        welcomeScreen.animationSpeed = 2.0
        view.addSubview(welcomeScreen)
        
        // when the animation is finished it will be remvoed from the superview so that we can see the homepage
        welcomeScreen.play { (finished) in
            if finished {
                self.welcomeScreen.removeFromSuperview()
            }
        }
    }
}

