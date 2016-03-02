//
//  spotModel.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/06/22.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import Foundation

class spotModel {
    let _api = accessToApi()
    let _appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func index(params: String) -> NSMutableDictionary {
        return _api.index("Spots", param: params)
    }
    
    func fetchSpots() -> Array<AnyObject> {
        let params: String = "kentei_id=5"
        let apiResponse: NSMutableDictionary = self.index(params)
        
        // *** レスポンスデータからスポット情報の抽出 ***
        let spotsMax: Int = apiResponse["response"]!["Spots"]!!.count
        print(spotsMax)
        var spots: Array<AnyObject> = []
        for var i = 0; i < spotsMax; i++ {
            spots.append(apiResponse["response"]!["Spots"]!![i]!["Spot"]!! as! Dictionary<String, String>)
        }
        return spots;
    }
}