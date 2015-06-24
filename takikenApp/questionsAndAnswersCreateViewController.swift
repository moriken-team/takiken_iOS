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
    // *** 問題文textview ***
    var _sentence = UITextView(frame: CGRectMake(30, 250, 310, 150))
    // *** 答えtextview ***
    var _answer = UITextView(frame: CGRectMake(30, 450, 310, 100))
    // *** 解説文textview ***
    var _description = UITextView(frame: CGRectMake(30, 600, 310, 200))
    let _problemModel: problemModel = problemModel()
    
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
        
        // *** キーボード用の入力完了ボタンの作成 ***
        var toolBar: UIToolbar!
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        // *** scrollViewの設定 ***
        var scrollView = UIScrollView()
        scrollView.frame =
            CGRectMake(origin.x, origin.y, imagePosition.width, imagePosition.height)
        scrollView.contentSize = CGSizeMake(imagePosition.width, 900)
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
        
        // *** 問題文ラベル ***
        var sentence_label = UILabel(frame: CGRectMake(30, 220, 100, 50))
        sentence_label.text = "問題文"
        sentence_label.textColor = UIColor.whiteColor()
        sentence_label.font = UIFont.systemFontOfSize(22)
        sentence_label.sizeToFit()
        
        // *** 答えラベル ***
        var answer_label = UILabel(frame: CGRectMake(30, 420, 100, 50))
        answer_label.text = "答え"
        answer_label.textColor = UIColor.whiteColor()
        answer_label.font = UIFont.systemFontOfSize(22)
        answer_label.sizeToFit()
        
        // *** 解説文ラベル ***
        var description_label = UILabel(frame: CGRectMake(30, 570, 100, 50))
        description_label.text = "解説文"
        description_label.textColor = UIColor.whiteColor()
        description_label.font = UIFont.systemFontOfSize(22)
        description_label.sizeToFit()
        
        // *** キーボード用編集完了ボタンの設置 ***
        _sentence.inputAccessoryView = toolBar
        _answer.inputAccessoryView = toolBar
        _description.inputAccessoryView = toolBar
        
        // *** 投稿ボタン ***
        var post_button = UIButton(frame: CGRectMake(33, 818, 300, 50))
        var button_image = UIImage(named: "btn057_03.png")
        //画像のリサイズ
        let size = CGSize(width: 300, height: 60)
        UIGraphicsBeginImageContext(size)
        button_image!.drawInRect(CGRectMake(0,0, size.width, size.height))
        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        post_button.setBackgroundImage(resizeImage, forState: .Normal)
        post_button.setTitle("問題を送信！", forState: .Normal)
        post_button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        post_button.titleLabel?.font = UIFont.systemFontOfSize(22)
        //ボタンをタップした時に実行するメソッドを指定
        post_button.addTarget(self, action: "postProblem:", forControlEvents:.TouchUpInside)

        // *** scrollVIewへのaddSubview ***
        scrollView.addSubview(title)
        scrollView.addSubview(explanation)
        scrollView.addSubview(notice)
        scrollView.addSubview(icon)
        scrollView.addSubview(_sentence)
        scrollView.addSubview(_answer)
        scrollView.addSubview(_description)
        scrollView.addSubview(sentence_label)
        scrollView.addSubview(answer_label)
        scrollView.addSubview(description_label)
        scrollView.addSubview(post_button)
        
    }
    
    // *** キーボード閉じる ***
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        _sentence.resignFirstResponder()
        _answer.resignFirstResponder()
        _description.resignFirstResponder()
    }
    
    // *** 問題投稿APIの実行 ***
    func postProblem(sender: UIButton) {
        var params: Array<String> = []
        params.append("sentence=" + _sentence.text)
        params.append("right_answer=" + _answer.text)
        params.append("description=" + _description.text)
        params.append("category_id=5")
        params.append("type=2")
        var response = _problemModel.insertCreateProblem(params)
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
