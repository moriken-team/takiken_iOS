//
//  mapTopViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/03/01.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

class mapTopViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var googleMap: GMSMapView!
    var gpsLocationManager = CLLocationManager()
    var checkGetGps: Bool?
    
    
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
    
    func showGoogleMap() {
        /*** GoogleMap利用の処理 start ***/
        let lat: CLLocationDegrees = appDelegate.gpsLat
        let lon: CLLocationDegrees = appDelegate.gpsLon
        let lat2: CLLocationDegrees = 39.704340
        let lon2: CLLocationDegrees = 141.137246
        
        let zoom: Float = 15
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat,longitude: lon,zoom: zoom);
        let camera2: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat2,longitude: lon2,zoom: zoom);
        let camera3: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(39.856134,longitude: 141.000232,zoom: zoom);
        let camera4: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(39.775439,longitude: 140.991821,zoom: zoom);
        let camera5: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(39.825423,longitude: 141.022892,zoom: zoom);
        let gpsMarker: GMSMarker = GMSMarker()
        let gpsMarker2: GMSMarker = GMSMarker()
        let gpsMarker3: GMSMarker = GMSMarker()
        let gpsMarker4: GMSMarker = GMSMarker()
        let gpsMarker5: GMSMarker = GMSMarker()
        
        googleMap = GMSMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        googleMap.camera = camera
        googleMap.delegate = self
        
        self.view.addSubview(googleMap)
        gpsMarker.position = camera.target
        gpsMarker.title = "現在地"
        //gpsMarker.snippet = "→詳細を見る←"
        gpsMarker.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker.map = googleMap
        
        gpsMarker2.position = camera2.target
        gpsMarker2.title = "旭橋"
        gpsMarker2.snippet = "→詳細を見る←"
        gpsMarker2.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker2.map = googleMap
        
        gpsMarker3.position = camera3.target
        gpsMarker3.title = "岩手山"
        gpsMarker3.snippet = "→詳細を見る←"
        gpsMarker3.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker3.map = googleMap
        
        gpsMarker4.position = camera4.target
        gpsMarker4.title = "小岩井農場"
        gpsMarker4.snippet = "→詳細を見る←"
        gpsMarker4.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker4.map = googleMap
        
        gpsMarker5.position = camera5.target
        gpsMarker5.title = "鞍掛山"
        gpsMarker5.snippet = "→詳細を見る←"
        gpsMarker5.appearAnimation = kGMSMarkerAnimationPop
        gpsMarker5.map = googleMap
        /*** GoogleMap利用の処理 end ***/
    }
    
    //CLLocationManagerオブジェクトにデリゲートオブジェクトを設定すると初回に呼ばれるメソッド。gpsを有効にするため設定ダイアログを表示させるために使う
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Author : \(status)")
        
        var statusStr: String?
//        switch (status) {
//        case .NotDetermined:
//            statusStr = "NotDetermined"
//            if gpsLocationManager.respondsToSelector("requestWhenInUseAuthorization") {
//                gpsLocationManager.requestWhenInUseAuthorization()
//            }
//        case .Restricted:
//            statusStr = "Restricted"
//        case .Denied:
//            statusStr = "Denied"
//        //case .Authorized:
//            //statusStr = "Authorized"
//        case .AuthorizedWhenInUse:
//            statusStr = "AuthorizedWhenInUse"
//        }
    }
    
    //位置情報の取得に成功したときに呼ばれるデリゲートメソッド
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        appDelegate.gpsLat = manager.location.coordinate.latitude
        appDelegate.gpsLon = manager.location.coordinate.longitude
        
        //googleMap描写の処理
        if checkGetGps == nil {
            showGoogleMap()
            checkGetGps = true
        }
        
        println("success")
        var location_log = String("\(manager.location.coordinate.latitude)") + ":" + String("\(manager.location.coordinate.longitude)")
        println(location_log)
    }
    
    //位置情報の取得に失敗した時に呼ばれるデリゲートメソッド
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //infoWindowをtapした時に呼ばれるデリゲートメソッド
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        println("\(marker.title)")
        performSegueWithIdentifier("spotInfo", sender: self)
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
