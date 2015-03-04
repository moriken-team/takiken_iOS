//
//  answerProblemTopViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/01.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerProblemTopViewController: UIViewController {

    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController!.anchorTopViewToRightAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(appDelegate.slidingViewController!.panGesture)
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
