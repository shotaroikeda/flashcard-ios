//
//  card.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

@IBDesignable class Card: UIView {
    var backgroundLayer : CAShapeLayer!
    var front = true
    
    @IBInspectable var frontText : myTextView!
    @IBInspectable var backText : myTextView!

    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if backgroundLayer == nil {
            initBackgroundLayer()
            initQuestionAndAnswerText()
            // Initialize var
            front = true
        }
    }
    
    func initQuestionAndAnswerText()
    {
        // Draw the UITextView to View
        frontText = myTextView(frame: CGRect(x: 10, y: 10, width: Int(bounds.width)-20, height: Int(bounds.height)-20))
        frontText.text = "Front Text"
        frontText.font = UIFont.boldSystemFontOfSize(18)
        frontText.textAlignment = .Center
        frontText.backgroundColor = UIColor.clearColor()
        frontText.textColor = UIColor.blackColor()
        
        backText = myTextView(frame: CGRect(x: 10, y: 10, width: Int(bounds.width)-20, height: Int(bounds.height)-20))
        backText.text = "Back Text"
        backText.font = UIFont.boldSystemFontOfSize(18)
        backText.textAlignment = .Center
        backText.backgroundColor = UIColor.clearColor()
        backText.textColor = UIColor.blackColor()
        // backtext should be invisible at first
        backText.alpha = 0
        
        // Vertical alignment
        var correct = (frontText.bounds.size.height - frontText.contentSize.height) * frontText.zoomScale/2.0
        correct = (correct < 0.0 ? 0.0 : correct)
        frontText.contentOffset = CGPoint(x: 0, y: -correct)
        correct = (backText.bounds.size.height - frontText.contentSize.height) * frontText.zoomScale/2.0
        correct = (correct < 0.0 ? 0.0 : correct)
        backText.contentOffset = CGPoint(x: 0, y: -correct)
        
        // Set editing properties
        frontText.editable = false
        backText.editable = false
        
        addSubview(frontText)
        addSubview(backText)
        
    }
    
    func initBackgroundLayer()
    {
        backgroundLayer = CAShapeLayer()
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: Int(bounds.width), height: Int(bounds.height))
        backgroundLayer.backgroundColor = UIColor.whiteColor().CGColor
        backgroundLayer.cornerRadius = 20
        backgroundLayer.borderColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).CGColor
        backgroundLayer.borderWidth = 1.0
        layer.addSublayer(backgroundLayer)
    }
    
    func showNextPanel()
    {
        print("Card Double tapped!")
        if front
        {
            UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseIn, animations: { self.frontText.alpha = 0 }, completion: nil)
            UIView.animateWithDuration(0.7, delay: 0.7, options: .CurveEaseIn, animations: { self.backText.alpha = 1 }, completion: nil)
        } else {
            UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseIn, animations: { self.backText.alpha = 0 }, completion: nil)
            UIView.animateWithDuration(0.7, delay: 0.7, options: .CurveEaseIn, animations: { self.frontText.alpha = 1 }, completion: nil)
        }
        front = !front
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
