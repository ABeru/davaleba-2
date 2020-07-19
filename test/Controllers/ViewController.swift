//
//  ViewController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/5/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var allow: UIButton!
    var locationManager = CLLocationManager()
    var lat: Double?
    var lon: Double?
    var some: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        //  locationManager.requestWhenInUseAuthorization()
        allow.layer.cornerRadius = 30
        some = true
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
           
            
        }
        
    }
    @IBAction func on(_ sender: UIButton) {
         locationManager.requestWhenInUseAuthorization()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.lat = location.coordinate.latitude
            self.lon = location.coordinate.longitude
            print(location.coordinate)
            if some! {
                performSegue(withIdentifier: "go", sender: nil)
                some = !some!
            }
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let identifier = segue.identifier, identifier == "go" {
            if let tabVC = segue.destination as? UITabBarController {
            if let someVc = tabVC.viewControllers!.first as? NearbyController {
              
                  someVc.lat = self.lat
                  someVc.lng = self.lon
                 
                
                }
              }
           }
       }}

