//
//  answerResultViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/04.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class answerResultViewController: UIViewController {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBAction func nextAction(sender: AnyObject) {
        appDelegate.answerProblemNumber!++
        if appDelegate.answerProblemNumber < appDelegate.problems.count {
            performSegueWithIdentifier("nextAnswer", sender: nil)
        }
        performSegueWithIdentifier("totalResult", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if isCorrectAnswer() {
            resultLabel.text = "正解"
            resultImage.image = UIImage(named: "kusudama.png")
        }else{
            resultLabel.text = "不正解"
            resultImage.image = UIImage(named: "kaminari.png")
        }
        rightAnswerLabel.text = appDelegate.rightAnswer
        descriptionLabel.text = appDelegate.rightDescription
        println(appDelegate.description)
        
        
        rightAnswerLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    
    func isCorrectAnswer() -> Bool {
        if appDelegate.answer! == appDelegate.rightAnswer! {
            return true
        }
        return false
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
