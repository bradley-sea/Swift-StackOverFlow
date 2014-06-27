//
//  WebViewController.swift
//  SwiftStackOverFlow
//
//  Created by Bradley Johnson on 6/26/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var webView : UIWebView = nil
    
    var publicKey = "5Vpg3uTqCwAssGUjZx73wg(("
    var oAuthDomain = "https://stackexchange.com/oauth/login_success"
    var clientID = "3197"
    var oAuthURL = "https://stackexchange.com/oauth/dialog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        var loginURL = "\(oAuthURL)?client_id=\(clientID)&redirect_uri=\(oAuthDomain)&scope=read_inbox"
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: loginURL)))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView!,
        shouldStartLoadWithRequest request: NSURLRequest!,
         navigationType: UIWebViewNavigationType) -> Bool
    
    {
        if request {
            var requestString = request.URL.description
            if requestString.rangeOfString("login_success") {
                if requestString.rangeOfString("expires") {
                      println("got it")
                    
                    let components = requestString.componentsSeparatedByString("=")
                    let tokenComponents = components[1].componentsSeparatedByString("&")
                    println(tokenComponents[0])
                    NetworkController.sharedNetworkController.token = tokenComponents[0]
                    self.dismissModalViewControllerAnimated(true)
                }
            }

        }
        return true
    }

    @IBAction func cancelPressed(sender : AnyObject) {
        
        self.dismissModalViewControllerAnimated(true)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
