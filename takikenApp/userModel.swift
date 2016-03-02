//
//  userModel.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/07/06.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import Foundation

class userModel {
    let _appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let _api:accessToApi = accessToApi()
    
    func login() {
        let params = ["User" : ["username" : "inoue", "password" : "inoue"]]
        //let response = _api.add("Logins", params: params)
    }
}