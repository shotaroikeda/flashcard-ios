//
//  flashCardData.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import Foundation
import SwiftyJSON

class Question : AnyObject
{
    var question : String
    var ans : String
    var weight : Double
    var tries : Int
    var total : Int
    
    /* Initializers */
    init()
    {
        question = "Question not set"
        ans = "Answer not set"
        weight = 1.0
        tries = 0
        total = 0
    }
    
    init(question : String, answer : String, weight : Double, tries_attempted : Int, total_attempted : Int)
    {
        self.question = question
        self.ans = answer
        self.weight = weight
        self.tries = tries_attempted
        self.total = total_attempted
    }
    
    init(json : JSON)
    {
        // TODO: Appropriate Association based off of results
        question = json["question"].stringValue
        ans = json["ans"].stringValue
        weight = json["weight"].doubleValue
        tries = json["tries"].intValue
        total = json["total"].intValue
    }
    
    /* Initializers */
    
}

class FlashCardData : AnyObject
{
    var classNames : [String]
    var flashCards : [String : [Question]]
    
    init()
    {
        classNames = []
        flashCards = [:]
    }
    
    func addClass(className : String, questionJSONArr : [JSON])
    {
        classNames.append(className)
        let questionObjs = questionJSONArr.map({ Question(json: $0) })
        flashCards[className] = questionObjs
    }
    
    func getQuestions(className : String) -> [Question]
    {
        if let questions = flashCards[className] {
            return questions
        } else {
            return []
        }
    }
}
