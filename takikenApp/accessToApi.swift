//
//  getApis.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/17.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import Foundation

class accessToApi {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let urlBase = "http://sakumon.jp/app/LK_API"
                   
    func index(resource: String, param: String) -> NSMutableDictionary {
        // *** 同期処理 ***
        let requestUrl = NSURL(string: "\(urlBase)/\(resource)/index.json?\(param)")
        print(requestUrl)
        let request:NSURLRequest = NSURLRequest(URL: requestUrl!)
        let requestData:NSData = try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        let json:NSMutableDictionary = (try! NSJSONSerialization.JSONObjectWithData(requestData, options: NSJSONReadingOptions.AllowFragments)) as! NSMutableDictionary
        
        print(json)
        return json
        
        // ***　非同期処理の場合は以下↓ ***
        //let config:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //let apiSession:NSURLSession = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        //let requestTask:NSURLSessionDataTask = apiSession.dataTaskWithURL(requestUrl!, completionHandler: {(data, response, error) -> Void in
        //    //var json:Dictionary<String, AnyObject> = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! Dictionary
        //    var json:NSMutableDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSMutableDictionary
        //    let problemMax:NSInteger = json["response"]!["Problems"]!!.count
        //    println(self._problems[0]["Problem"]!?["sentence"]!)
        //    self.test.text = self._problems[0]["Problem"]!?["sentence"]! as? String
        //    self.performSegueWithIdentifier("nextAnswer", sender: self)
        //})
        //requestTask.resume()
    }
    
    func add(resource:String, params:String) -> NSMutableDictionary {
        // *** 同期処理 ***
        let postParams = params.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let requestUrl = NSURL(string: "\(urlBase)/\(resource)/add.json")
        print(requestUrl)
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: requestUrl!)
        // POSTで送信
        request.HTTPMethod = "POST"
        request.HTTPBody = postParams
        
        let requestData:NSData = try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        let json:NSMutableDictionary = (try! NSJSONSerialization.JSONObjectWithData(requestData, options: NSJSONReadingOptions.AllowFragments)) as! NSMutableDictionary
        
        print(json)
        return json
    }
}