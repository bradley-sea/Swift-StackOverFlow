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
    var answerCount = 0
    var title = ""
    var questionID = 0
    var score = 0
    var askDate = NSDate()
    
    class func questinsFromJSON(jsonData : NSMutableArray) -> Question[]{
        
        var questions = Question[]()
        
        for jsonQuestion : AnyObject in jsonData {
            var question = Question()
            question.isAnwsered = jsonQuestion.objectForKey("is_answered") as Int
            question.title = jsonQuestion.objectForKey("title") as String
            question.questionID = jsonQuestion.objectForKey("question_id") as Int
            question.score = jsonQuestion.objectForKey("score") as Int
            question.answerCount = jsonQuestion.objectForKey("answer_count") as Int
            var epochDate = jsonQuestion.objectForKey("creation_date") as Int
            var epochTime = NSTimeInterval(epochDate)
            question.askDate = NSDate(timeIntervalSince1970: epochTime)
            questions += question
        }
        return questions
    }
}