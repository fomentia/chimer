//
//  ViewController.swift
//  Chimer
//
//  Created by Isaac Williams on 3/15/16.
//  Copyright © 2016 The Williams Family. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var blackViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet var whiteTimerLabel: UILabel!
    @IBOutlet var blackTimerLabel: UILabel!

    @IBOutlet var blackView: UIView!
    @IBOutlet var whiteView: UIView!

    var whiteTimer: NSTimer!
    var blackTimer: NSTimer!
    
    var whiteTime: Int = 1800
    var blackTime: Int = 1800
    
    var activeTimer: NSTimer!
    var timerWhenPaused: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blackViewHeightConstraint.constant = self.view.frame.height / 2
        blackTimerLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
    
    override func viewWillAppear(animated: Bool) {
        updateWhiteLabel()
        updateBlackLabel()
    }

    func updateWhiteTimer() {
        if let at = activeTimer {
            if at == whiteTimer {
                whiteTime -= 1
                updateWhiteLabel()
            }
        }
    }

    func updateBlackTimer() {
        if let at = activeTimer {
            if at == blackTimer {
                blackTime -= 1
                updateBlackLabel()
            }
        }
    }
    
    func updateWhiteLabel() {
        let minutes = Int(whiteTime / 60)
        let seconds = whiteTime - (minutes * 60)
        if seconds == 0 {
            whiteTimerLabel.text = "\(minutes):00"
        } else {
            whiteTimerLabel.text = "\(minutes):\(seconds)"
        }
    }
    
    func updateBlackLabel() {
        let minutes = Int(blackTime / 60)
        let seconds = blackTime - (minutes * 60)
        if seconds == 0 {
            blackTimerLabel.text = "\(minutes):00"
        } else {
            blackTimerLabel.text = "\(minutes):\(seconds)"
        }
    }

    @IBAction func switchWhiteTimer(sender: UITapGestureRecognizer) {
        if activeTimer == nil {
            whiteTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateWhiteTimer"), userInfo: nil, repeats: true)
            blackTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateBlackTimer"), userInfo: nil, repeats: true)
            activeTimer = whiteTimer
        } else {
            activeTimer = blackTimer
        }
    }
    
    @IBAction func switchBlackTimer(sender: UITapGestureRecognizer) {
        activeTimer = whiteTimer
    }

    @IBAction func resetTimers(sender: UIButton) {
        whiteTime = 1800
        blackTime = 1800
        
        updateWhiteLabel()
        updateBlackLabel()
        
        timerWhenPaused = whiteTimer
    }

    @IBAction func pauseTimers(sender: UIButton) {
        if sender.titleLabel!.text == "Pause" {
            blackView.gestureRecognizers![0].enabled = false
            whiteView.gestureRecognizers![0].enabled = false
            timerWhenPaused = activeTimer
            activeTimer = nil
            sender.setTitle("Resume", forState: .Normal)
        } else {
            blackView.gestureRecognizers![0].enabled = true
            whiteView.gestureRecognizers![0].enabled = true
            activeTimer = timerWhenPaused
            sender.setTitle("Pause", forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nav = segue.destinationViewController as! UINavigationController
        let dvc = nav.topViewController as! SettingsController
        dvc.parent = self
    }
}

