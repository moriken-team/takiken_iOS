//
//  showSpotProblemViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/05.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class showSpotProblemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //スクリーンの幅
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        //CGRectで取得
        let myImage = UIImage(named: "kokuban.jpg")!
        let myImageView = UIImageView()
        myImageView.image = myImage
        myImageView.frame = CGRectMake(0, 64, screenWidth, screenHeight - 109)
        //self.view.addSubview(myImageView)
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
