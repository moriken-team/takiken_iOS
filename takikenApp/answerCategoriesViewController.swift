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
    let _problemModel: problemModel = problemModel()
    var toolBar: UIToolbar!
    var textField: UITextField!
    
    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
    }
    
    @IBAction func challengeProbem(sender: AnyObject) {
        _problemModel.setUpAnswer()
        self.performSegueWithIdentifier("nextAnswer", sender: self)
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
