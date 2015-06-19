//
//  answerCategoriesViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/03.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerCategoriesViewController: UIViewController, UIPickerViewDelegate,UIToolbarDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate, PopUpPickerViewDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var category = ["滝沢のなりたち・概要","自然", "施設", "神社・仏閣", "伝統・文化", "都市整備", "交通", "人物", "イベント", "産業", "生涯学習", "メディア"]
    let _problemModel: problemModel = problemModel()
    var picker: PopUpPickerView! = PopUpPickerView()
    
    @IBOutlet weak var selectCategoryButton: UIButton!
    
    @IBAction func selectCategory(sender: AnyObject) {
        picker.showPicker()
    }
    
    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
    }
    
    @IBAction func challengeProbem(sender: AnyObject) {
        _problemModel.setUpAnswer()
        self.performSegueWithIdentifier("nextAnswer", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // *** PopUpPickerViewを利用するためのデリゲートの設定とaddSubview ***
        picker.delegate = self
        self.view.addSubview(picker)
        
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
        selectCategoryButton.setTitle("\(category[row])▼", forState: .Normal)
        selectCategoryButton.titleLabel?.adjustsFontSizeToFitWidth = true
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
