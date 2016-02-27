//
//  flashcardDetailViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

class flashcardDetailViewController: UIViewController {
    var cardFront: Card!
    var cardMid: Card!
    var cardBack: Card!
    var cardInvisible: Card!
    
    var classTitle : String = "ClassNotSet"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = classTitle

        // Do any additional setup after loading the view.
        cardFront = Card()
        cardMid = Card()
        cardBack = Card()
        
        // Set up workableRegion
        let workableWidth = self.view.bounds.width
        let workableHeight = self.view.bounds.height
        let workableStartX = self.view.bounds.minX
        let workableStartY = self.view.bounds.minY

        let cardWidth = workableWidth - 70
        let cardHeight = workableHeight - 200
        
        // Set up cards...
        cardFront.frame = CGRect(x: 50, y: (self.navigationController?.navigationBar.frame.size.height)!+40, width: cardWidth, height: cardHeight)
        cardMid.frame = CGRect(x: 35, y: (self.navigationController?.navigationBar.frame.size.height)!+55, width: cardWidth, height: cardHeight)
        cardBack.frame = CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.size.height)!+70, width: cardWidth, height: cardHeight)
        
        view.addSubview(cardBack)
        view.addSubview(cardMid)
        view.addSubview(cardFront)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
