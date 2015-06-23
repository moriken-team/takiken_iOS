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
        showGoogleMap()
    }
    
    func showGoogleMap() {
        let spotApi: spotModel = spotModel()
        let spots = spotApi.fetchSpots()
        
        /*** GoogleMapへのスポット表示処理 start ***/
        let initLat: CLLocationDegrees = appDelegate.gpsLat
        let initLon: CLLocationDegrees = appDelegate.gpsLon
        let zoom: Float = 15
        let initCamera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(initLat,longitude: initLon,zoom: zoom);
        googleMap = GMSMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        googleMap.camera = initCamera
        googleMap.delegate = self
        let spotsMax = spots.count
        for var i = 0; i < spotsMax; i++ {
            let lat: CLLocationDegrees = (spots[i]["latitude"] as! NSString).doubleValue
            let lon: CLLocationDegrees = (spots[i]["longitude"] as! NSString).doubleValue
            let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat,longitude: lon,zoom: zoom);
            let marker: GMSMarker = GMSMarker()
            self.view.addSubview(googleMap)
            marker.position = camera.target
            marker.title = spots[i]["name"] as! String
            marker.snippet = "→詳細を見る←"
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = googleMap
        }
        /*** GoogleMapへのスポット表示処理 end ***/
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
        //if checkGetGps == nil {
            //showGoogleMap()
            checkGetGps = true
        //}
        
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
