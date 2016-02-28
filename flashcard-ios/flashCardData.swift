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
    var right : Int
    var total : Int
    
    /* Initializers */
    init()
    {
        question = "Question not set"
        ans = "Answer not set"
        weight = 1.0
        right = 0
        total = 0
    }
    
    init(question : String, answer : String)
    {
        self.question = question
        self.ans = answer
        self.weight = 1.0
        self.right = 0
        self.total = 0
    }
    
    init(question : String, answer : String, weight : Double, right_attempted : Int, total_attempted : Int)
    {
        self.question = question
        self.ans = answer
        self.weight = weight
        self.right = right_attempted
        self.total = total_attempted
    }
    
    init(json : JSON)
    {
        // TODO: Appropriate Association based off of results
        question = json["question"].stringValue
        ans = json["ans"].stringValue
        weight = json["weight"].doubleValue
        right = json["right"].intValue
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
    
    init(classNamesArr : [String], flashCardsMap : [String : [Question]])
    {
        classNames = classNamesArr
        flashCards = flashCardsMap
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
