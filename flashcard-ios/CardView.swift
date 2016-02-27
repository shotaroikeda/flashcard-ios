//
//  cardView.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    @IBInspectable var firstCard : Card!
    @IBInspectable var middleCard : Card!
    @IBInspectable var lastCard : Card!
    
    @IBAction func selectCorrect(sender: UIButton) {
        
    }
    
    @IBAction func selectIncorrect(sender: UIButton) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstCard = CardView.instanceFromNib("Card") as! Card
        middleCard = CardView.instanceFromNib("Card") as! Card
        lastCard = CardView.instanceFromNib("Card") as! Card
        /*
        firstCard.frame = CGRect(x: 30, y: 30, width: Int(bounds.width)-60, height: Int(bounds.height/2)-30)
        middleCard.frame = CGRect(x: 30, y: 30, width: Int(bounds.width)-60, height: Int(bounds.height/2)-30)
        lastCard.frame = CGRect(x: 30, y: 30, width: Int(bounds.width)-60, height: Int(bounds.height/2)-30)
        */
        addSubview(firstCard)
        addSubview(middleCard)
        addSubview(lastCard)
    }
    
    class func instanceFromNib(nibName : String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}