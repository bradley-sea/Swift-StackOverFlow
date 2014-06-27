//
//  NetworkController.swift
//  SwiftStackOverFlow
//
//  Created by Bradley Johnson on 6/26/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import Foundation


class NetworkController {
    
    class var sharedNetworkController : NetworkController {
    return _SingletonSharedInstance
    }
    let apiDomain = "http://api.stackexchange.com/2.2/"
    let apiSite = "site=stackoverflow"
    var urlSession : NSURLSession!
    var authController : AuthController!
    var token : String?
    
    init(){
        //setup a standard NSURL Session
    let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.urlSession = NSURLSession(configuration: configuration)
        self.authController = AuthController()
    }
    
    func retrieveQuestionsFor( searchTerm : String, withCompletion completionClosure: (answers :Question[]) -> ()) {
        
        var apiEndpoint = "\(self.apiDomain)search?tagged=\(searchTerm)&\(apiSite)"
        
        let postDataTask = self.urlSession.dataTaskWithURL(NSURL(string: apiEndpoint)) {
            (data :NSData!,response: NSURLResponse!, error :NSError!) in
            
            if error {
                println("we got an error!")
                println(error.localizedDescription)
            }
            else {
            println(response)
            var jsonError : NSError?
            var responseJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:&jsonError) as NSDictionary
                if jsonError {
                    println(jsonError!.localizedDescription)
                }
                else {
            var jsonQuestions = responseJSON["items"] as NSMutableArray
            var questions = Question.questinsFromJSON(jsonQuestions)
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock() { () in

                        completionClosure(answers: questions)
                    }
                }
            }
        }
        postDataTask.resume()
    }
}

let _SingletonSharedInstance = NetworkController()
