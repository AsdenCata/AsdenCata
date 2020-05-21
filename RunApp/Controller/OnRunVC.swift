//
//  OnRunVC.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 20/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit

class OnRunVC: LocationVC {  //inherit everithing from LocationVC
    
    @IBOutlet weak var swipeBackgroundImg: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImg.addGestureRecognizer(swipeGesture)
        sliderImg.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 80 //values are given based on how they look on the screen
        let maxAdjust: CGFloat = 129
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view) // give us how many points we are adding or substracting from the current location
                if sliderView.center.x >= (swipeBackgroundImg.center.x - minAdjust) && sliderView.center.x <= (swipeBackgroundImg.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x //seting the center of the slider to move according to the swipeGesture, between the min and max points(Adjust
                } else if sliderView.center.x >= (swipeBackgroundImg.center.x + maxAdjust){
                    sliderView.center.x = swipeBackgroundImg.center.x + maxAdjust //adjust if slider got to far to right from view
                     // TO DO: end running code goes here
                    dismiss(animated: true, completion: nil)
                } else {
                    sliderView.center.x = swipeBackgroundImg.center.x - minAdjust    //adjust if slider go to far to left from view
                }
                sender.setTranslation(CGPoint.zero, in: self.view) //set the translation value of the coordonate system in the specifil view
            } else if sender.state == UIGestureRecognizer.State.ended {  //se the slider to return to initial value if not dragged to end
                UIView.animate(withDuration: 0.2) {
                    sliderView.center.x = self.swipeBackgroundImg.center.x - minAdjust
                }
                
            }
            
        }
        
    }
    
    
}
