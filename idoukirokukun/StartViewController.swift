//
//  StartViewController.swift
//  idoukirokukun
//
//  Created by 清水拓郎 on 2020/06/19.
//  Copyright © 2020 清水拓郎. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StartViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    var locManager: CLLocationManager!
    var colorNumber = 0
    @IBOutlet var label: UILabel!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager = CLLocationManager()
        locManager.delegate = self
        
        //位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                //座標の表示
                locManager.startUpdatingLocation()
                break
            default:
                break
           
            }
            mapView.showsUserLocation = true
        }
        initMap()
       
        
        
    }
    
    
    func initMap() {
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.1
        region.span.longitudeDelta = 0.1
        mapView.setRegion(region, animated: true)
        
        //現在位置表示の有効化
        mapView.showsUserLocation = true
        //現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される
        mapView.userTrackingMode = .follow
    }
    
    
    @IBAction func blueButtonTapped() {
        colorNumber = 0
        label.text = "選択中の色：青"
    }
    
    @IBAction func redButtonTapped() {
        colorNumber = 1
        label.text = "選択中の色：赤"
    }
    
    @IBAction func greenButtonTapped() {
        colorNumber = 2
        label.text = "選択中の色：緑"
    }
    
    @IBAction func grayButtonTapped() {
        colorNumber = 3
        label.text = "選択中の色：グレー"
    }
    
    //セグエの実行
    @IBAction func startButtonTapped() {
        performSegueToRecord()
    }
    
    //セグエの実行と値渡しの中身
    func performSegueToRecord() {
        performSegue(withIdentifier: "toRecordView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecordView" {
            let recordViewController = segue.destination as! RecordViewController
            recordViewController.colorNumber = self.colorNumber
        }
    }
    
    @IBAction func back(sender: UIStoryboardSegue) {
        
    }


}

