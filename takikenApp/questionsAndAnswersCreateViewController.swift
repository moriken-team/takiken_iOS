//
//  questionsAndAnswersCreateViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/03.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class questionsAndAnswersCreateViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var backgroundImage: UIImageView!
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
        //背景画像のbouds
        let imagePosition = backgroundImage.bounds
        //背景画像のorigin
        let origin = backgroundImage.frame.origin
        
        //CGRectで取得
//        let myImage = UIImage(named: "kokuban.jpg")!
//        var myImageView = UIImageView()
//        myImageView.image = myImage
//        myImageView.frame = CGRectMake(0, 64, screenWidth, screenHeight - 109)
        //self.view.addSubview(myImageView)
        var scrollView = UIScrollView()
        scrollView.frame =
            CGRectMake(origin.x, origin.y, imagePosition.width, imagePosition.height)
        scrollView.contentSize = CGSizeMake(imagePosition.width, 1000)
        self.view.addSubview(scrollView)
        
        // *** タイトルラベル ***
        var title = UILabel(frame: CGRectMake(30, 40, 200, 50))
        title.text = "1問1答問題を作ろう！"
        title.textColor = UIColor.whiteColor()
        title.font = UIFont.systemFontOfSize(33)
        title.sizeToFit()
        
        // *** 機能説明ラベル ***
        var explanation = UILabel(frame: CGRectMake(26, 90, 270, 60))
        explanation.text = "問題を作りながら滝沢市について勉強してみましょう"
        explanation.textColor = UIColor.whiteColor()
        explanation.font = UIFont.systemFontOfSize(22)
        //文字が入りきらない場合は改行
        explanation.lineBreakMode = NSLineBreakMode.ByCharWrapping
        //行数を0に設定し、動的な複数行に対応
        explanation.numberOfLines = 0;
        
        // *** 形式通知ラベル ***
        var notice = UILabel(frame: CGRectMake(25, 150, 330, 60))
        notice.text = "1問1問形式の問題を考えましょう"
        notice.textColor = UIColor.redColor()
        notice.font = UIFont.systemFontOfSize(21)
        
        // *** アイコン画像 ***
        var icon = UIImageView(image: UIImage(named: "pen_mannenhitsu.png"))
        icon.frame = CGRectMake(290, 80, 70, 80)
        
        
        
        // *** scrollVIewへのaddSubview ***
        scrollView.addSubview(title)
        scrollView.addSubview(explanation)
        scrollView.addSubview(notice)
        scrollView.addSubview(icon)
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
