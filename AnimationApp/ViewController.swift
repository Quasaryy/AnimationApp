//
//  ViewController.swift
//  AnimationApp
//
//  Created by Yury on 02.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var springAnimationView: UIView!
    @IBOutlet var coreAnimationView: UIView!
    @IBOutlet var springButton: UIButton!
    
    var originPosition: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        originPosition = coreAnimationView.frame.origin.x
    }
    
    @IBAction func coreButtonTapped(_ sender: UIButton) {
        buttonAnimation(button: sender)
        animateView()
        shakeButton(button: springButton)
    }
    
    @IBAction func springButtonTapped(_ sender: UIButton) {
        shakeButton(button: springButton)
    }
}

extension ViewController {
    private func animateView() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
            if self.coreAnimationView.frame.origin.x == self.originPosition {
                self.coreAnimationView.frame.origin.x += 20
                self.coreAnimationView.frame.origin.x -= 40
            }
        }
    }
    
    private func buttonAnimation(button: UIButton) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.duration = 0.2
        
        button.layer.add(animation, forKey: nil)
    }
    
    private func shakeButton(button: UIButton) {
        let animation = CAKeyframeAnimation (keyPath: "position.x")
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.08, 0.25, 0.415, 0.5]
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        
        button.layer.add(animation, forKey: nil)
    }
    
}

