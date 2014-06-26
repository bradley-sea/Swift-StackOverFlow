//
//  Question.swift
//  SwiftStackOverFlow
//
//  Created by Bradley Johnson on 6/26/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import Foundation


class Question {
    var ownerName = ""
    var ownerID = ""
    var ownerLink = ""
    var isAnwsered = 0
    var answerCount = ""
    var title = ""
    var questionID = 0
    
    class func questinsFromJSON(jsonData : NSMutableArray) -> Question[]{
        
        var questions = Question[]()
        
        for jsonQuestion : AnyObject in jsonData {
            var question = Question()
            println(jsonQuestion)
            question.isAnwsered = jsonQuestion.objectForKey("is_answered") as Int
            question.title = jsonQuestion.objectForKey("title") as String
            question.questionID = jsonQuestion.objectForKey("question_id") as Int
            questions += question
        }
        return questions
    }
}