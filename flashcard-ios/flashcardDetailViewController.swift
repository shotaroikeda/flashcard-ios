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
    var tapRecogPlane: UIView!
    
    var classTitle : String = "ClassNotSet"
    var doubleTap : UITapGestureRecognizer!
    
    var questions : [Question]! = [Question()]

    var questionsQueue : [Question]! {
        didSet {
            if questionsQueue.count == 0 {
                self.populateQueue()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the double tap handler
        doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        doubleTap.numberOfTapsRequired = 2
        
        self.navigationItem.title = classTitle

        // Do any additional setup after loading the view.
        cardFront = Card()
        cardMid = Card()
        cardBack = Card()
        cardInvisible = Card()
        
        // Set up workableRegion
        let workableWidth = self.view.bounds.width
        let workableHeight = self.view.bounds.height

        let cardWidth = workableWidth - 70
        let cardHeight = workableHeight - 200
        
        // Set up cards...
        cardFront.frame = CGRect(x: 50, y: (self.navigationController?.navigationBar.frame.size.height)!+40, width: cardWidth, height: cardHeight)
        cardMid.frame = CGRect(x: 35, y: (self.navigationController?.navigationBar.frame.size.height)!+55, width: cardWidth, height: cardHeight)
        cardBack.frame = CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.size.height)!+70, width: cardWidth, height: cardHeight)
        cardInvisible.frame = CGRect(x: 5, y: (self.navigationController?.navigationBar.frame.size.height)!+85, width: cardWidth, height: cardHeight)
        
        // Card invisible is invisible
        cardInvisible.alpha = 0

        
        // Add the subviews
        view.addSubview(cardBack)
        view.addSubview(cardMid)
        view.addSubview(cardFront)
        // Add Gesture recognizers for cards...
        

        // Set the recognization plane
        tapRecogPlane = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: (self.navigationController?.navigationBar.frame.size.height)!+70))
        tapRecogPlane.backgroundColor = UIColor.clearColor() // Change to clear
        tapRecogPlane.addGestureRecognizer(doubleTap)
        view.addSubview(tapRecogPlane)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        tapRecogPlane.removeGestureRecognizer(doubleTap)
    }
    
    func doubleTapped ()
    {
        print("Tap is working")
        cardFront.showNextPanel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateQueue()
    {
        // TODO: can be optimized (hacky)
        let totalWeight = questionsQueue.reduce(0.0) { (n : Double, q : Question) -> Double in
            return n + q.weight
        }
        let weightArrs = (0..<25).map({ (_ : Int) -> Double in
            Double(Float(arc4random()) / Float(UINT32_MAX)) * totalWeight
        })
        
        questionsQueue = weightArrs.map({ return findWeight($0) })
    }
    
    func findWeight(weight : Double) -> Question
    {
        var inc : Double = 0.0
        for q in questions
        {
            inc += q.weight
            if weight <= inc
            {
                return q
            }
        }
        return questions[questions.count-1]
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
