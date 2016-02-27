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
    
    @IBInspectable var frontText : UITextView!
    @IBInspectable var backText : UITextView!

    override func layoutSubviews() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            backgroundLayer.frame = CGRect(x: 0, y: 0, width: Int(bounds.width), height: Int(bounds.height))
            backgroundLayer.backgroundColor = UIColor.whiteColor().CGColor
            backgroundLayer.cornerRadius = 20
            backgroundLayer.borderColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).CGColor
            backgroundLayer.borderWidth = 1.0
            layer.addSublayer(backgroundLayer)
            
            frontText = UITextView(frame: CGRect(x: 10, y: 10, width: Int(bounds.width)-20, height: Int(bounds.height)-20))
            frontText.text = "Front Text"
            frontText.font = UIFont.boldSystemFontOfSize(36)
            frontText.textAlignment = .Center
            frontText.backgroundColor = UIColor.clearColor()

            backText = UITextView(frame: CGRect(x: 10, y: 10, width: Int(bounds.width)-20, height: Int(bounds.height)-20))
            backText.text = "Back Text"
            backText.font = UIFont.boldSystemFontOfSize(36)
            backText.textAlignment = .Center
            backText.backgroundColor = UIColor.clearColor()
            backText.textColor = UIColor.clearColor()
            
            // Vertical alignment
            var correct = (frontText.bounds.size.height - frontText.contentSize.height) * frontText.zoomScale/2.0
            correct = (correct < 0.0 ? 0.0 : correct)
            frontText.contentOffset = CGPoint(x: 0, y: -correct)
            correct = (backText.bounds.size.height - frontText.contentSize.height) * frontText.zoomScale/2.0
            correct = (correct < 0.0 ? 0.0 : correct)
            backText.contentOffset = CGPoint(x: 0, y: -correct)

            addSubview(frontText)
            addSubview(backText)
            
            // Initialize var
            front = false
            
            // Detect double tap gesture
            let tap = UITapGestureRecognizer(target: self, action: "doubleTapped")
            tap.numberOfTapsRequired = 2
            addGestureRecognizer(tap)
        }
    }
    
    func doubleTapped()
    {
        if front
        {
            UIView.animateWithDuration(1, animations: { self.frontText.textColor = UIColor.clearColor() })
            UIView.animateWithDuration(1, animations: { self.backText.textColor = UIColor.blackColor() })
        } else {
            UIView.animateWithDuration(1, animations: { self.frontText.textColor = UIColor.blackColor() })
            UIView.animateWithDuration(1, animations: { self.backText.textColor = UIColor.clearColor() })
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
