//
//  ViewController.swift
//  AnimationApp
//
//  Created by Yury on 02.02.23.
//

import UIKit
import Spring

class ViewController: UIViewController {
    
    @IBOutlet var coreAnimationView: UIView!
    @IBOutlet var springAnimationView: SpringView!
    @IBOutlet var springButton: SpringButton!
    
    var originPosition: CGFloat!
    
    // MARK: Override Methods
    override func viewWillLayoutSubviews() {
        originPosition = coreAnimationView.frame.origin.x
    }
    
    // MARK: IB Actions
    @IBAction func coreButtonTapped(_ sender: UIButton) {
        buttonAnimation(button: sender)
        
        animateView()
        shakeView(view: coreAnimationView)
    }
    
    @IBAction func springButtonTapped(_ sender: SpringButton) {
        springAnimationView.animation = Spring.AnimationPreset.FadeInLeft.rawValue
        springAnimationView.animate()
        
        animationForSpringButton(button: springButton)
    }
    
    
}
// MARK: Private Methods
extension ViewController {
    private func animateView() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) { [weak self] in
            guard let self = self else { return }
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
    
    private func shakeView(view: UIView) {
        let animation = CAKeyframeAnimation (keyPath: "position.x")
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.08, 0.25, 0.415, 0.5]
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        
        view.layer.add(animation, forKey: nil)
    }
    
    private func animationForSpringButton(button: SpringButton) {
        button.animation = Spring.AnimationPreset.Morph.rawValue
        button.curve = Spring.AnimationCurve.EaseOut.rawValue
        button.duration = 0.5
        button.animate()
    }
    
}

