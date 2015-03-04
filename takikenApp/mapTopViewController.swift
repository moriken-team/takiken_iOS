//
//  mapTopViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/01.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class mapTopViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var googleMap: GMSMapView!
    var gpsLocationManager = CLLocationManager()
    var checkGps: String?
    
    @IBAction func menuShowOnTap(sender: AnyObject) {
        appDelegate.slidingViewController!.anchorTopViewToRightAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(appDelegate.slidingViewController!.panGesture)
        
        showGoogleMap()
        
        ///*** GPS利用の処理 start ***/
        //gpsLocationManager.delegate = self
        //
        //let gpsStatus = CLLocationManager.authorizationStatus()
        //
        //if gpsStatus == CLAuthorizationStatus.NotDetermined {
        //    println("設定してください")
        //    //self.gpsLocationManager.requestAlwaysAuthorization()
        //    self.gpsLocationManager.requestWhenInUseAuthorization()
        //}
        //
        //gpsLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //gpsLocationManager.distanceFilter = 100
        //
        //gpsLocationManager.startUpdatingLocation()
        ///*** GPS利用の処理 end ***/
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if checkGps == "success" {
            //showGoogleMap()
        }else{
            println("だめー")
        }
    }
    
    override func viewWillLayoutSubviews() {
        println("レイアウトビュー")
    }
    
    func showGoogleMap() {
        /*** GoogleMap利用の処理 start ***/
        println("\(appDelegate.gpsLat)")
        println("\(appDelegate.gpsLon)")
        let lat: CLLocationDegrees = appDelegate.gpsLat
        let lon: CLLocationDegrees = appDelegate.gpsLon
        //let lat: CLLocationDegrees = 39.701831
        //let lon: CLLocationDegrees = 141.141860
        let lat2: CLLocationDegrees = 39.704340
        let lon2: CLLocationDegrees = 141.137246
        
        let zoom: Float = 15
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat,longitude: lon,zoom: zoom);
        let camera2: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat2,longitude: lon2,zoom: zoom);
        let gpsMarker: GMSMarker = GMSMarker()
        let gpsMarker2: GMSMarker = GMSMarker()
        
        googleMap = GMSMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        googleMap.camera = camera
        googleMap.delegate = self
        
        self.view.addSubview(googleMap)
        gpsMarker.position = camera.target
        gpsMarker.title = "盛岡駅"
        gpsMarker.snippet = "→詳細を見る←"
        gpsMarker.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker.map = googleMap
        
        gpsMarker2.position = camera2.target
        gpsMarker2.title = "旭橋"
        gpsMarker2.snippet = "→詳細を見る←"
        gpsMarker2.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker2.map = googleMap
        /*** GoogleMap利用の処理 end ***/
    }
    
    ////CLLocationManagerオブジェクトにデリゲートオブジェクトを設定すると初回に呼ばれるメソッド。gpsを有効にするため設定ダイアログを表示させるために使う
    //func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    //    println("Author : \(status)")
    //    
    //    var statusStr: String?
    //    switch (status) {
    //    case .NotDetermined:
    //        statusStr = "NotDetermined"
    //        if gpsLocationManager.respondsToSelector("requestWhenInUseAuthorization") {
    //            gpsLocationManager.requestWhenInUseAuthorization()
    //        }
    //        println("NotDeterminedきた")
    //    case .Restricted:
    //        statusStr = "Restricted"
    //    case .Denied:
    //        statusStr = "Denied"
    //    case .Authorized:
    //        statusStr = "Authorized"
    //    case .AuthorizedWhenInUse:
    //        statusStr = "AuthorizedWhenInUse"
    //        showGoogleMap()
    //    }
    //    checkGps = statusStr
    //    println("status： \(checkGps)")
    //}
    //
    ////位置情報の取得に成功したときに呼ばれるデリゲート
    //func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    //    appDelegate.gpsLat = manager.location.coordinate.latitude
    //    appDelegate.gpsLon = manager.location.coordinate.longitude
    //    checkGps = "success"
    //    
    //    println("success")
    //    var location_log = String("\(manager.location.coordinate.latitude)") + ":" + String("\(manager.location.coordinate.longitude)")
    //    println(location_log)
    //    
    //}
    //
    ////位置情報の取得に失敗した時に呼ばれるデリゲート
    //func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    //    checkGps = "error"
    //    println("error")
    //}

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
