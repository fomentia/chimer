//
//  SettingsController.swift
//  Chimer
//
//  Created by Isaac Williams on 3/16/16.
//  Copyright © 2016 The Williams Family. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    
    var parent: ViewController!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func timeLimitChanged(sender: UISlider) {
        let roundedValue = Int(round(sender.value))
        minutes = roundedValue
        timeLabel.text = "\(minutes) min."
        sender.setValue(Float(minutes), animated: true)
    }

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if minutes != nil {
            parent.blackTime = minutes * 60
            parent.whiteTime = minutes * 60
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}