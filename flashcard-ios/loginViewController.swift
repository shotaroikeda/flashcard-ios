//
//  ViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/26/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var sloganText: UILabel!
    @IBOutlet var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Hide the slogan for the appearing effect
        // Initial configuration for loginView
        loginView.alpha = 0
        
        // SloganText configuration
        sloganText.alpha = 0
        
        // Animate sequentially
        UIView.animateWithDuration(1, delay: 0.0, options: .CurveEaseIn,
            animations: { self.sloganText.alpha = 1 },
            completion: fadeInLoginView)
    }
    
    func fadeInLoginView(_: Bool)
    {
        UIView.animateWithDuration(1, delay: 0.0, options: .CurveEaseIn,
            animations: { self.loginView.alpha = 1 },
            completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.loginView.endEditing(true)
    }
}

