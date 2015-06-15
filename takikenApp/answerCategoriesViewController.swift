//
//  answerCategoriesViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/03.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerCategoriesViewController: UIViewController, UIPickerViewDelegate,UIToolbarDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var category = ["滝沢のなりたち・概要","自然", "施設", "神社・仏閣", "伝統・文化", "都市整備", "交通", "人物", "イベント", "産業", "生涯学習", "メディア"]
    var toolBar: UIToolbar!
    var textField: UITextField!
    
    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
    }
    
    @IBAction func challengeProbem(sender: AnyObject) {
        // *** APIによる問題取得 ***
        let params = "kentei_id=1&employ=2012&grade=3&category_id=1&item=5"
        let requestUrl = NSURL(string: "http://sakumon.jp/app/LK_API/problems/index.json?\(params)")
        let request:NSURLRequest = NSURLRequest(URL: requestUrl!)
        let requestData:NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        var json:NSMutableDictionary = NSJSONSerialization.JSONObjectWithData(requestData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSMutableDictionary
        println(json["response"]!["Problems"]!![0]["Problem"]!!["sentence"])
        
        // *** respons内の問題情報を保存 ***
        let problemMax:NSInteger = json["response"]!["Problems"]!!.count
        for var i = 0; i < problemMax; ++i {
            appDelegate.problems[i] = json["response"]!["Problems"]!![i]
        }
        // *** 問題情報の値取得 => problems[0]["Problem"]!?["sentence"]! as? String ***
        
        // ***　非同期処理の場合は以下↓ ***
        //let config:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //let apiSession:NSURLSession = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        //let requestTask:NSURLSessionDataTask = apiSession.dataTaskWithURL(requestUrl!, completionHandler: {(data, response, error) -> Void in
        //    //var json:Dictionary<String, AnyObject> = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! Dictionary
        //    //NSDictionaryの場合は下記の変換をする
        //    var json:NSMutableDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSMutableDictionary
        //    let problemMax:NSInteger = json["response"]!["Problems"]!!.count
        //    println(self._problems[0]["Problem"]!?["sentence"]!)
        //    self.test.text = self._problems[0]["Problem"]!?["sentence"]! as? String
        //    self.performSegueWithIdentifier("nextAnswer", sender: self)
        //})
        //requestTask.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //スクリーンの幅
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        //CGRectで取得
        let myImage = UIImage(named: "kokuban.jpg")!
        var myImageView = UIImageView()
        myImageView.image = myImage
        myImageView.frame = CGRectMake(0, 64, screenWidth, screenHeight - 109)
        //self.view.addSubview(myImageView)
        
        //textField = UITextField(frame: CGRectMake(self.view.frame.size.width/3, 200, 0, 0))
        textField = UITextField(frame: CGRectMake(210, 392, 100, 0))
        textField.placeholder = "未選択"
        textField.sizeToFit()
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont.systemFontOfSize(22)
        self.view.addSubview(textField)
        
        var pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        
        textField.inputView = pickerView
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        textField.inputAccessoryView = toolBar
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return category[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = category[row]
        textField.sizeToFit()
    }
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.view.addGestureRecognizer(appDelegate.slidingViewController!.panGesture)
        appDelegate.slidingViewController?.anchorRightPeekAmount = 200.0
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