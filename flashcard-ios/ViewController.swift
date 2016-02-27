//
//  ViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/26/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var sloganText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Hide the slogan for the appearing effect
        sloganText.alpha = 0
        UIView.animateWithDuration(1, delay: 0.2, options: .CurveEaseIn, animations: { self.sloganText.alpha = 1 }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

