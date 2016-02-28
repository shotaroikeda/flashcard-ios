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
    var swipeLeft : UISwipeGestureRecognizer!
    var swipeRight : UISwipeGestureRecognizer!

    var questions : [Question]! = [Question()]
    var first : Bool = true

    var questionsQueue : [Question]! {
        didSet {
            if questionsQueue.count == 4 {
                self.populateQueue()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = classTitle
        loadCards()
        
        // Initialize Gestures
        initGestures()
        
        // Add buttons
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        cardFront.removeFromSuperview()
        cardMid.removeFromSuperview()
        cardBack.removeFromSuperview()
        cardInvisible.removeFromSuperview()

        tapRecogPlane.removeGestureRecognizer(doubleTap)
        tapRecogPlane.removeGestureRecognizer(swipeLeft)
        tapRecogPlane.removeGestureRecognizer(swipeRight)
    }
    
    func loadCards() {
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
        cardInvisible.frame = CGRect(x: -30, y: (self.navigationController?.navigationBar.frame.size.height)!+120, width: cardWidth, height: cardHeight)
        
        // Card invisible is invisible
        cardInvisible.alpha = 0
        
        // Add the subviews
        view.addSubview(cardInvisible)
        view.addSubview(cardBack)
        view.addSubview(cardMid)
        view.addSubview(cardFront)
    }
    
    // MARK: Animation/Queue helper functions
    func shiftQueue(finished: Bool)
    {
        if finished {
            self.view.userInteractionEnabled = false
            // clean up
            cardFront.removeFromSuperview()
            cardMid.removeFromSuperview()
            cardBack.removeFromSuperview()
            cardInvisible.removeFromSuperview()
            tapRecogPlane.removeFromSuperview()
            
            // reload the cards
            loadCards()
            
            self.view.addSubview(tapRecogPlane)
            self.view.userInteractionEnabled = true
        }
    }
    
    // MARK: Gesture recognizer
    func initGestures () {
        // Set the double tap handler
        doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped")
        doubleTap.numberOfTapsRequired = 2
        
        // Set the swiping gestures
        swipeLeft = UISwipeGestureRecognizer(target: self, action: "leftSwipe")
        swipeRight = UISwipeGestureRecognizer(target: self, action: "rightSwipe")
        swipeLeft.direction = .Left
        swipeRight.direction = .Right
        
        // Set the recognization plane
        tapRecogPlane = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: (self.navigationController?.navigationBar.frame.size.height)!+70+cardBack.frame.height))
        tapRecogPlane.backgroundColor = UIColor.clearColor() // Change to clear
        tapRecogPlane.addGestureRecognizer(doubleTap)
        tapRecogPlane.addGestureRecognizer(swipeLeft)
        tapRecogPlane.addGestureRecognizer(swipeRight)

        view.addSubview(tapRecogPlane)
    }
    
    func doubleTapped ()
    {
        print("Tap is working")
        cardFront.showNextPanel()
    }
    
    func leftSwipe ()
    {
        print("left swipe")
        // Animation...
        
        // Movement animations
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveLinear, animations: { [unowned self] in
            // cardFront Animations
            self.cardFront.center.x -= 50
            self.cardFront.center.y += 50
            // self.cardFront.transform = CGAffineTransformMakeScale(0.5, 0.5)
            // self.cardFront.transform = CGAffineTransformMakeRotation(6*CGFloat(M_PI))

            // cardMid animations
            self.cardMid.center.x += 15
            self.cardMid.center.y -= 15
            
            // cardBack animations
            self.cardBack.center.x += 15
            self.cardBack.center.y -= 15
            
            // cardInvisible animations
            self.cardInvisible.center.x += 50
            self.cardInvisible.center.y -= 50
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { [unowned self] in
            // cardFront Animations
            self.cardFront.alpha = 0
            // cardInvisible Animation
            self.cardInvisible.alpha = 1
            }, completion: shiftQueue)

    }
    
    func rightSwipe ()
    {
        print("right swipe")
        
        // Animation...
        
        // Movement animations
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveLinear, animations: { [unowned self] in
            // cardFront Animations
            self.cardFront.center.x += 50
            self.cardFront.center.y -= 50
            
            // cardMid animations
            self.cardMid.center.x += 15
            self.cardMid.center.y -= 15
            
            // cardBack animations
            self.cardBack.center.x += 15
            self.cardBack.center.y -= 15
            
            // cardInvisible animations
            self.cardInvisible.center.x += 50
            self.cardInvisible.center.y -= 50
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { [unowned self] in
            // cardFront Animations
            self.cardFront.alpha = 0
            // cardInvisible Animation
            self.cardInvisible.alpha = 1
            }, completion: shiftQueue)
        
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
