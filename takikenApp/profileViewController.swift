//
//  profileViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/03.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController?.anchorTopViewToRightAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.slidingViewController?.underLeftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Menu") as UIViewController
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