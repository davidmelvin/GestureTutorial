//
//  CanvasViewController.swift
//  Gestures
//
//  Created by David Melvin on 6/30/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    
    @IBOutlet weak var trayView: UIView!
    var center: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        center = trayView.center
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: self.center.x, y: self.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(trayView)
        
        if sender.state == .Began {
            self.center = trayView.center
        } else if sender.state == .Changed {
            trayView.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
        } else {
            let velocity = sender.velocityInView(trayView)
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.3, animations: { 
                    self.trayView.center = self.trayDown
                })
            }
            
            else {
                UIView.animateWithDuration(0.3, animations: { 
                    self.trayView.center = self.trayUp
                })
            }
        }
    }
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(trayView)
        
        if sender.state == .Began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.userInteractionEnabled = true
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        }
        else if sender.state == .Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else {
            
        }
    }
 
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(trayView)
        
        if sender.state == .Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
