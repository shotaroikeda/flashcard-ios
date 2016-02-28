//
//  LoginView.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

@IBDesignable
class LoginView: UIView, UITextFieldDelegate {
    var backgroundLayer: CAShapeLayer!
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.grayColor()
    @IBInspectable var lineWidth: CGFloat = 1.0
    var usernameInput: UITextField!
    var passwordInput: UITextField!
    var loginButton: UIButton!
    var forgotButton: UIButton!
    var firstLaunch = true
    
    let actInd = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstLaunch
        {
            setBackgroundLayer()
            setTextFields()
            self.addSubview(usernameInput)
            self.addSubview(passwordInput)
            
            setButtons()
            self.addSubview(loginButton)
            self.addSubview(forgotButton)
            
            // Slide in username+password field
            // TODO: Check for iPad
            UIView.animateWithDuration(2, delay: 1.2, options: .CurveLinear, animations: { self.usernameInput.center.x += 1015 }, completion: nil)
            UIView.animateWithDuration(2, delay: 1.2, options: .CurveLinear, animations: { self.passwordInput.center.x -= 1015 }, completion: nil)
            UIView.animateWithDuration(1, delay: 3.2, options: .CurveEaseIn, animations: { self.loginButton.alpha = 1 }, completion: nil)
            UIView.animateWithDuration(1, delay: 3.2, options: .CurveEaseIn, animations: { self.forgotButton.alpha = 1 }, completion: nil)
            
            firstLaunch = false
        }
    }
    
    @IBAction func handleLogin()
    {
        endEditing(true)
        
        // Make the activity Indicator not suck
        self.usernameInput.userInteractionEnabled = false
        self.passwordInput.userInteractionEnabled = false
        // Disable login + forgot password button
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: { self.forgotButton.alpha = 0 }, completion: nil)
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: { self.loginButton.alpha = 0 }) { [unowned self] (finish : Bool) in
            self.loginButton.userInteractionEnabled = false
            self.forgotButton.userInteractionEnabled = false
            
            // Add a box around the indicator
            let backgroundWidth = Double(self.backgroundLayer.frame.width)
            let backgroundHeight = Double(self.backgroundLayer.frame.height)
            
            self.actInd.center = CGPoint(x: backgroundWidth/2, y: backgroundHeight-65)
            self.actInd.layer.cornerRadius = 10
            self.actInd.activityIndicatorViewStyle = .WhiteLarge
            self.actInd.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
            self.addSubview(self.actInd)
            self.actInd.startAnimating()

            
            // Put firebase login function here
            ref.authUser(self.usernameInput.text, password: self.passwordInput.text, withCompletionBlock: {
                err, authData in
                if err != nil {
                    // Show error here
                    self.actInd.stopAnimating()
                    self.actInd.removeFromSuperview()
                    self.loginFail()
                } else {
                    let currUser = ref.childByAppendingPath("users").childByAppendingPath(authData.uid)
                    currUser.observeEventType(.Value, withBlock: { snapshot in
                        // Parse Data to JSON array
                        var classes:[JSON] = []
                        let data = JSON(snapshot.value)
                        for(_, subJson):(String, JSON) in data {
                            for(_, subJsonTwo):(String, JSON) in subJson {
                                classes.append(subJsonTwo)
                            }
                        }
                        
                        self.actInd.stopAnimating()
                        self.actInd.removeFromSuperview()
                        print(classes)
                        self.loginSuccess(classes)
                        // Snapshot received
                    })
                    
                }
            })
        }
    }
    
    func loginSuccess(classes: [JSON])
    {
        print("Successful log in!")
        
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }

        let storyboard = UIStoryboard(name: "flashcards", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("flashcard-entry") as! flashcardViewController
        controller.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        controller.userJSON = classes
        topVC?.presentViewController(controller, animated: true, completion: nil)
    }
    
    func loginFail()
    {
        self.usernameInput.userInteractionEnabled = true
        self.passwordInput.userInteractionEnabled = true

        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: { self.loginButton.alpha = 1 }) { [unowned self] (finish : Bool) in
            self.loginButton.userInteractionEnabled = true
        }
        
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: { self.forgotButton.alpha = 1 }) { [unowned self] (finish : Bool) in
            self.forgotButton.userInteractionEnabled = true
        }
        
        let alert = UIAlertController(title: "Login Failed", message: "Either your username or password is invalid.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
        
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        topVC?.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func handleForgot()
    {
        endEditing(true)
        print("Forgot password pressed!")
    }
    
    func setButtons()
    {
        // Background width + height vars
        let backgroundWidth = Double(backgroundLayer.frame.width)
        let backgroundHeight = Double(backgroundLayer.frame.height)

        loginButton = UIButton(type: .Custom)
        loginButton.addTarget(self, action: "handleLogin", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.frame = CGRect(x: 15, y: backgroundHeight-75-backgroundHeight/6, width: backgroundWidth-30, height: backgroundHeight/6)
        loginButton.layer.cornerRadius = 10
        // Login button theming
        loginButton.layer.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).CGColor
        loginButton.titleLabel!.textColor = UIColor.whiteColor()
        loginButton.titleLabel!.textAlignment = .Center
        loginButton.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
        // Invisible for animation
        loginButton.alpha = 0
        
        /* Forgot Button */
        forgotButton = UIButton(type: .Custom)
        forgotButton.addTarget(self, action: "handleForgot", forControlEvents: UIControlEvents.TouchUpInside)
        forgotButton.setTitle("Forgot Password?", forState: .Normal)
        forgotButton.frame = CGRect(x: 15, y: backgroundHeight-60, width: backgroundWidth-30, height: backgroundHeight/6)
        forgotButton.layer.cornerRadius = 10
        // Login button theming
        forgotButton.layer.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1).CGColor
        forgotButton.titleLabel!.textColor = UIColor.whiteColor()
        forgotButton.titleLabel!.textAlignment = .Center
        forgotButton.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
        // Invisible for animation
        forgotButton.alpha = 0

    }
    
    func setTextFields() {
        let backgroundWidth = Double(backgroundLayer.frame.width)
        let backgroundHeight = Double(backgroundLayer.frame.height)
        usernameInput = UITextField(frame: CGRect(x: -1000, y: 15,
            width: backgroundWidth-30, height: backgroundHeight/6))
        usernameInput.placeholder = "username"
        usernameInput.textAlignment = NSTextAlignment.Center
        usernameInput.font = UIFont.systemFontOfSize(15)
        // usernameInput.borderStyle = UITextBorderStyle.RoundedRect
        usernameInput.layer.cornerRadius = 10
        /* // Code with green highlight
        usernameInput.layer.borderColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1).CGColor
        */
        usernameInput.layer.borderColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).CGColor
        usernameInput.layer.backgroundColor = UIColor.whiteColor().CGColor
        usernameInput.layer.borderWidth = 1.0
        usernameInput.autocorrectionType = UITextAutocorrectionType.No
        usernameInput.keyboardType = UIKeyboardType.EmailAddress
        usernameInput.returnKeyType = UIReturnKeyType.Next
        usernameInput.clearButtonMode = UITextFieldViewMode.WhileEditing;
        usernameInput.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        usernameInput.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        usernameInput.autocapitalizationType = .None
        usernameInput.delegate = self
        
        passwordInput = UITextField(frame: CGRect(x: 1030, y: 30+backgroundHeight/6,
            width: backgroundWidth-30, height: backgroundHeight/6))
        passwordInput.placeholder = "password"
        passwordInput.textAlignment = NSTextAlignment.Center
        passwordInput.font = UIFont.systemFontOfSize(15)
        // passwordInput.borderStyle = UITextBorderStyle.RoundedRect
        passwordInput.layer.cornerRadius = 10
        /* // Code with green highlight
        passwordInput.layer.borderColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1).CGColor
        */
        passwordInput.layer.borderColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).CGColor
        passwordInput.layer.backgroundColor = UIColor.whiteColor().CGColor
        passwordInput.layer.borderWidth = 1.0
        passwordInput.autocorrectionType = UITextAutocorrectionType.No
        passwordInput.keyboardType = UIKeyboardType.Default
        passwordInput.returnKeyType = UIReturnKeyType.Done
        passwordInput.clearButtonMode = UITextFieldViewMode.WhileEditing;
        passwordInput.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        passwordInput.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        passwordInput.secureTextEntry = true
        passwordInput.delegate = self
    }
    
    func setBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            backgroundLayer.fillColor = UIColor(red: 237/255, green: 239/255, blue: 241/255, alpha: 1.0).CGColor
            backgroundLayer.bounds = bounds
            backgroundLayer.path = UIBezierPath(roundedRect: backgroundLayer.bounds, cornerRadius: 20).CGPath
        }
        
        backgroundLayer.frame = layer.bounds
    }
    let sampleTextField = UITextField(frame: CGRectMake(20, 100, 300, 40))
    
    // MARK: Textfield Delegates
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == usernameInput)
        {
            passwordInput.becomeFirstResponder()
        } else {
            textField.resignFirstResponder();
            handleLogin()
        }
        return true;
    }
    // MARK: Textfield Delegates

}
