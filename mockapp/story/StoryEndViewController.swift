//
//  StoryEndViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 1/17/24.
//

import UIKit
import Lottie

class StoryEndViewController: UIViewController {
    
    var StoryLength: String?
    
    @IBAction func BackHome(_ sender: UIButton) {
        
        if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }
       
    }
    
    @IBAction func Continue(_ sender: UIButton) {
        let forwardedWord = StoryLength
        let jumpBack = self.storyboard?.instantiateViewController(withIdentifier: "StoryTableViewController") as! StoryTableViewController
        jumpBack.forwardedWord = forwardedWord
        self.navigationController?.pushViewController(jumpBack, animated: true)
    }
    
    @IBOutlet weak var SomeText: UILabel!
    
    @IBOutlet weak var StoryLottie: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let StoryLength = StoryLength else { return }
      //  SomeText.text = "The End"
        lottieAnimation()
        
        navigationItem.hidesBackButton = true
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    func lottieAnimation() {
        let animation = LottieAnimationView(name: "search")
                animation.translatesAutoresizingMaskIntoConstraints = false

                StoryLottie.addSubview(animation)

                // Set up constraints to make the animation fill the storySpace view
                NSLayoutConstraint.activate([
                    animation.topAnchor.constraint(equalTo: StoryLottie.topAnchor),
                    animation.leadingAnchor.constraint(equalTo: StoryLottie.leadingAnchor),
                    animation.trailingAnchor.constraint(equalTo: StoryLottie.trailingAnchor),
                    animation.bottomAnchor.constraint(equalTo: StoryLottie.bottomAnchor)
                ])

                animation.play()
                animation.loopMode = .loop
            }

}
