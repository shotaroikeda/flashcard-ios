//
//  flashcardViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit
import SwiftyJSON

class flashcardViewController: UINavigationController {

    var userJSON : [JSON]!
    var userFlashCardData : FlashCardData = FlashCardData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var classNames : [String] = []
        var classQuestionMap : [String : [Question]] = [:]
        
        for classObj in userJSON
        {
            if classObj["class_name"] == nil
            {
                continue
            }
            
            let className = classObj["class_name"].stringValue.uppercaseString
            classNames.append(className)
            var questionArr : [Question] = []
            for (key, questionObj) in classObj["questions"]
            {
                if key == "0" {
                    continue
                } else {
                    // TODO: more values from Firebase
                    let tempQuestionObj : Question = Question(question: questionObj["question"].stringValue, answer: questionObj["answer"].stringValue)
                    questionArr.append(tempQuestionObj)
                }
            }
            classQuestionMap[className] = questionArr
        }
        
        userFlashCardData = FlashCardData(classNamesArr: classNames, flashCardsMap: classQuestionMap)
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
