//
//  AppDelegate.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/02/14.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var slidingViewController: ECSlidingViewController?
    //デフォルトは盛岡駅
    var gpsLat: Double = 39.702004
    var gpsLon: Double = 141.136098
    var gpsLocationManager = CLLocationManager()
    var checkGps: String?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBMtO1fNcnpd8HBam8mpg2wEDAQ_dYinC8")
        slidingViewController = self.window!.rootViewController as? ECSlidingViewController
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        slidingViewController?.topViewController = storyBoard.instantiateViewControllerWithIdentifier("Top") as UIViewController
        // Override point for customization after application launch.
        return true
    }
    
    func startGpsManager() {
        /*** GPS利用の処理 start ***/
        gpsLocationManager.delegate = self
        
        let gpsStatus = CLLocationManager.authorizationStatus()
        
        if gpsStatus == CLAuthorizationStatus.NotDetermined {
            println("設定してください")
            //self.gpsLocationManager.requestAlwaysAuthorization()
            self.gpsLocationManager.requestWhenInUseAuthorization()
        }
        
        gpsLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        gpsLocationManager.distanceFilter = 100
        
        gpsLocationManager.startUpdatingLocation()
        /*** GPS利用の処理 end ***/
    }
    
    //CLLocationManagerオブジェクトにデリゲートオブジェクトを設定すると初回に呼ばれるメソッド。gpsを有効にするため設定ダイアログを表示させるために使う
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Author : \(status)")
        
        var statusStr: String?
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
            if gpsLocationManager.respondsToSelector("requestWhenInUseAuthorization") {
                gpsLocationManager.requestWhenInUseAuthorization()
            }
            println("NotDeterminedきた")
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .Authorized:
            statusStr = "Authorized"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
            //showGoogleMap()
        }
        checkGps = statusStr
        println("status： \(checkGps)")
    }
    
    //位置情報の取得に成功したときに呼ばれるデリゲート
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        gpsLat = manager.location.coordinate.latitude
        gpsLon = manager.location.coordinate.longitude
        checkGps = "success"
        
        println("success")
        var location_log = String("\(manager.location.coordinate.latitude)") + ":" + String("\(manager.location.coordinate.longitude)")
        println(location_log)
        
    }
    
    //位置情報の取得に失敗した時に呼ばれるデリゲート
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        checkGps = "error"
        println("error")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

