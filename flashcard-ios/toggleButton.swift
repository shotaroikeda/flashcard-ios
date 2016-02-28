//
//  flashCardEditView.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/28/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

@IBDesignable class toggleButton: UIView {
    var backgroundLayer: CAShapeLayer!
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.grayColor()
    @IBInspectable var lineWidth: CGFloat = 1.0
    var toggleButton: UIButton!
    var cancelButton: UIButton!
    @IBInspectable var modeName : String!
    @IBInspectable var handleToggle : (() -> Void)!
    @IBInspectable var handleCancel : (() -> Void)!
    
    func toggle() {
        handleToggle()
    }
    
    func cancel() {
        handleCancel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setBackgroundLayer()
        setButtons()
        self.addSubview(toggleButton)
        self.addSubview(cancelButton)
    }
    
    func setButtons()
    {
        // Background width + height vars
        let backgroundWidth = Double(backgroundLayer.frame.width)
        let backgroundHeight = Double(backgroundLayer.frame.height)
        
        toggleButton = UIButton(type: .Custom)
        toggleButton.addTarget(self, action: "toggle", forControlEvents: UIControlEvents.TouchUpInside)
        toggleButton.setTitle(modeName, forState: .Normal)
        toggleButton.frame = CGRect(x: 15, y: 15, width: backgroundWidth-30, height: backgroundHeight/3)
        toggleButton.layer.cornerRadius = 10
        // Login button theming
        toggleButton.layer.backgroundColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1).CGColor
        toggleButton.titleLabel!.textColor = UIColor.whiteColor()
        toggleButton.titleLabel!.textAlignment = .Center
        toggleButton.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
        // Invisible for animation
        toggleButton.alpha = 1
        
        /* Forgot Button */
        cancelButton = UIButton(type: .Custom)
        cancelButton.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.frame = CGRect(x: 15, y: Int(bounds.size.height)-15-Int(backgroundHeight/3), width: Int(backgroundWidth-30), height: Int(backgroundHeight/3))
        cancelButton.layer.cornerRadius = 10
        // Login button theming
        cancelButton.layer.backgroundColor = UIColor(red: 0.918, green: 0.38, blue: 0.325, alpha: 1).CGColor
        cancelButton.titleLabel!.textColor = UIColor.whiteColor()
        cancelButton.titleLabel!.textAlignment = .Center
        cancelButton.titleLabel!.font = UIFont.boldSystemFontOfSize(20)
        // Invisible for animation
        cancelButton.alpha = 1
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
}
