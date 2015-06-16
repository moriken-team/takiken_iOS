//
//  answerSelectionViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/04.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerSelectionViewController: UIViewController {
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var selectAnswer1: UIButton!
    @IBOutlet weak var selectAnswer2: UIButton!
    @IBOutlet weak var selectAnswer3: UIButton!
    @IBOutlet weak var selectAnswer4: UIButton!
    
    @IBAction func choice(sender: AnyObject) {
        //正誤判定用するために選択した選択肢の情報を保存
        appDelegate.answer = sender.titleLabel!!.text!
        performSegueWithIdentifier("result", sender: nil)
    }
    
    @IBAction func backVIew(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *** 問題選択肢ランダム処理 ***
        let right_answer = appDelegate.problems[0]["Problem"]!!["right_answer"]! as? String
        let wrong_answer1 = appDelegate.problems[0]["Problem"]!!["wrong_answer1"]! as? String
        let wrong_answer2 = appDelegate.problems[0]["Problem"]!!["wrong_answer2"]! as? String
        let wrong_answer3 = appDelegate.problems[0]["Problem"]!!["wrong_answer3"]! as? String
        let defaultAnswers: [String] = [right_answer!, wrong_answer1!, wrong_answer2!, wrong_answer3!]
        let shuffleAnswers = shuffleArray(defaultAnswers)
        //正誤判定用するために正解選択肢の情報を保存
        appDelegate.rightAnswer = defaultAnswers[0]
        appDelegate.rightDescription = appDelegate.problems[0]["Problem"]!!["description"]! as? String
        
        println(defaultAnswers)
        
        // *** ビューに問題情報の表示 ***
        sentenceLabel.text = appDelegate.problems[0]["Problem"]!!["sentence"] as? String
        selectAnswer1.setTitle(shuffleAnswers[0], forState: .Normal)
        selectAnswer2.setTitle(shuffleAnswers[1], forState: .Normal)
        selectAnswer3.setTitle(shuffleAnswers[2], forState: .Normal)
        selectAnswer4.setTitle(shuffleAnswers[3], forState: .Normal)
                               
        // *** 文字サイズ自動収縮の設定 ***
        sentenceLabel.adjustsFontSizeToFitWidth = true
        selectAnswer1.titleLabel!.adjustsFontSizeToFitWidth = true
        selectAnswer2.titleLabel!.adjustsFontSizeToFitWidth = true
        selectAnswer3.titleLabel!.adjustsFontSizeToFitWidth = true
        selectAnswer4.titleLabel!.adjustsFontSizeToFitWidth = true
        
        // Do any additional setup after loading the view.
    }
    
    func shuffleArray(target: [String]) -> [String] {
        var tmpTarget = target
        var randArray: [String] = []
        var index: Int
        while !tmpTarget.isEmpty {
            index = Int(arc4random_uniform(UInt32(tmpTarget.count)))
            randArray.append(tmpTarget[index])
            tmpTarget.removeAtIndex(index)
        }
        return randArray
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
