//
//  answerTotalResultViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/04.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerTotalResultViewController: UIViewController {

    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // *** ナビゲーションバーのbackボタンを非表示にする（TODO:ベストな方法に変更） ***
        self.navigationItem.title = ""
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Do any additional setup after loading the view.
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
