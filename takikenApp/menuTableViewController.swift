//
//  menuTableViewController.swift
//  takikenApp
//
//  Created by 井上 裕之 on 2015/02/14.
//  Copyright (c) 2015年 takiken. All rights reserved.
//

import UIKit

//class menuTableViewController: UITableViewController, UITableViewDelegate,CLLocationManagerDelegate {
class menuTableViewController: UITableViewController, CLLocationManagerDelegate {

    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let categoryList = ["ホーム","問題解答","問題作成","たきざわMAP"]
    var gpsLocationManager = CLLocationManager()
    var checkGps: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("ロードされた")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        print("ロードされた2")
        return categoryList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        print("番号 = \(indexPath.row)")
        cell.textLabel?.text = categoryList[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("番号 = \(indexPath.row)")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0 {
            print("home kita---")
            appDelegate.slidingViewController?.topViewController = storyBoard.instantiateViewControllerWithIdentifier("Top") 
        } else if indexPath.row == 1 {
            print("answer kita---")
            appDelegate.slidingViewController?.topViewController = storyBoard.instantiateViewControllerWithIdentifier("answerTop") 
        } else if indexPath.row == 2 {
            print("create kita---")
            appDelegate.slidingViewController?.topViewController = storyBoard.instantiateViewControllerWithIdentifier("createTop") 
        } else if indexPath.row == 3 {
            print("map kita---")
            //startGpsManager()
            appDelegate.slidingViewController?.topViewController = storyBoard.instantiateViewControllerWithIdentifier("mapTop") 
        }
        appDelegate.slidingViewController?.resetTopViewAnimated(true)
    }
    
    //func startGpsManager() {
    //    /*** GPS利用の処理 start ***/
    //    gpsLocationManager.delegate = self
    //    
    //    let gpsStatus = CLLocationManager.authorizationStatus()
    //    
    //    if gpsStatus == CLAuthorizationStatus.NotDetermined {
    //        println("設定してください")
    //        //self.gpsLocationManager.requestAlwaysAuthorization()
    //        self.gpsLocationManager.requestWhenInUseAuthorization()
    //    }
    //    
    //    gpsLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    //    gpsLocationManager.distanceFilter = 100
    //    
    //    gpsLocationManager.startUpdatingLocation()
    //    /*** GPS利用の処理 end ***/
    //}
    //
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
    //        //showGoogleMap()
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
    
    //override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //    return 50
    //}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
