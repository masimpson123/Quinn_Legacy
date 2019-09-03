//
//  ViewController.swift
//  Quinn
//
//  Created by Michael Simpson on 8/14/19.
//  Copyright © 2019 Smart Commuter Incorporated. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var greeting: UILabel!
    @IBOutlet var callToAction: UITextView!
    @IBOutlet var quinnImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let deviceWidth = UIScreen.main.bounds.width
        greeting.frame.origin.x = (deviceWidth - 300)/2
        callToAction.frame.origin.x = (deviceWidth - 300)/2
        quinnImage.frame.origin.x = (deviceWidth - 200)/2
    }


}

