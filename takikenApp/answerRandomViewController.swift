//
//  answerRandomViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/23.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerRandomViewController: UIViewController {
    
    let _appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let _problemModel: problemModel = problemModel()

    @IBAction func challengeProbem(sender: AnyObject) {
        let params:String = "kentei_id=1&public_flag=1&item=5"
        _problemModel.setUpAnswer(params)
        performSegueWithIdentifier("nextAnswer", sender: self)
    }
    
    @IBAction func showSideMenu(sender: AnyObject) {
        _appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.addGestureRecognizer(_appDelegate.slidingViewController!.panGesture)
        _appDelegate.slidingViewController?.anchorRightPeekAmount = 200.0
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
