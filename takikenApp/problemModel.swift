//
//  problemModel.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/17.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import Foundation

class problemModel {
    
    let _api = accessToApi()
    let _appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func index(params: String) -> NSMutableDictionary {
        return _api.index("Problems", param: params)
    }
    
    func setUpAnswer() {
        let params:String = "kentei_id=1&employ=2012&grade=3&public_flag=1&category_id=1&item=5"
        let apiResponse = self.index(params)
        // *** 解答する問題通し番号・正解数・問題データの初期化 ***
        _appDelegate.answerProblemNumber = 0
        _appDelegate.correctCount = 0
        _appDelegate.problems = NSMutableArray()
        
        // *** respons内の問題情報を保存 ***
        let problemMax:NSInteger = apiResponse["response"]!["Problems"]!!.count
        for var i = 0; i < problemMax; ++i {
            _appDelegate.problems[i] = apiResponse["response"]!["Problems"]!![i]
        }
    }
}