//
//  oneQuestionAnswerViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/03.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class oneQuestionAnswerViewController: UIViewController, UIPickerViewDelegate,UIToolbarDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var num = ["2013年度","2014年度"]
    var toolBar: UIToolbar!
    var textField: UITextField!

    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
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
        textField = UITextField(frame: CGRectMake(195, 355, 0, 0))
        textField.placeholder = "年度を選択してください"
        textField.sizeToFit()
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont.systemFontOfSize(28)
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
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        textField.inputAccessoryView = toolBar
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return num.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return num[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = num[row]
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
