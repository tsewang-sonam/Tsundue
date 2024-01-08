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
    
    

    
    @IBOutlet weak var quotesDisplay: UILabel!
    
    private var welcomeScreen : LottieAnimationView!
   
    @IBOutlet var tableView : UITableView!
    
    @IBOutlet weak var searchTop: LottieAnimationView!
    
    @IBOutlet weak var storyTop: LottieAnimationView!
    
    @IBOutlet weak var vocabularyTop: LottieAnimationView!
    
    @IBOutlet weak var quizTop: LottieAnimationView!
    
    @IBAction func storyButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    @IBAction func vocabularyButton(_ sender: UIButton) {
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Displays a lottie at the starting of the application
       // lottieWelcome()
        
        //Displays a random quotes on the UILable quotes Display on the home screen
        quotesDisplay.text = quotes.randomElement()?.description
        
        
        // Four lottie Animation for the buttons namely (search,  read,  vocab,  vocabulary)
        lottieAnimation(string : "search" , outletButton: searchTop)
       lottieAnimation(string :"read",outletButton: storyTop)
        lottieAnimation(string :"vocab",outletButton: vocabularyTop)
        lottieAnimation(string :"vocabulary",outletButton: quizTop)
    }
    
    // function for the lottie animation
    func lottieAnimation(string : String, outletButton : LottieAnimationView) {
      
        let animation = LottieAnimation.named(string)
               outletButton.animation = animation
               outletButton.loopMode = .loop
               outletButton.play()
    }
    
    
    //function for the initial lotties that display when opening app
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
    
    
    
    // Array storing multiple quotations
    
    let quotes : [String] = [ "A disciplined mind brings happiness.  - Buddha ",
                             "The way is not in the sky. The way is in the heart.  - Buddha",
                             "To be angry is to let others' mistakes punish yourself.   - Buddha",
                             "There is no path to happiness. Happiness is the path.  - Buddha",
                             "One who acts on truth is happy in this world and beyond.  - Buddha",
                             "True charity occurs only when there are no notions of giving, giver, or gift. - Buddha",
                             "You only lose what you cling to.  - Buddha",
                             "True change is within, leave the outside as it is.- Dalai Lama" ]
    
}

