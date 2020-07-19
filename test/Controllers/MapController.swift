//
//  MapController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/11/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var map1: MKMapView!
    var lat: Double?
    var lon: Double?
        let locationManager = CLLocationManager()
    var loc1 = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        loc1 = CLLocationCoordinate2D(latitude: Locations.sharedInstance.array.first!.0, longitude: Locations.sharedInstance.array.first!.1)
        print("ok", lat, lon)
        print(Locations.sharedInstance.array.first!,Locations.sharedInstance.array.count)
         
        map1.delegate = self
        for l in Locations.sharedInstance.array {
            addAnnotations(lat1: l.0, lon1: l.1, name: l.2,sub: l.3)
        }
        
        //   map1.showsUserLocation = true
           if CLLocationManager.locationServicesEnabled(){
                 locationManager.delegate = self
                 locationManager.desiredAccuracy = kCLLocationAccuracyBest
                 locationManager.startUpdatingLocation()
            map1.showsUserLocation = true
               //  centerMapView()
             }
   
    }
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.first {
        print(location.coordinate)
           self.lat = location.coordinate.latitude
           self.lon = location.coordinate.longitude
            // locationManager.stopUpdatingLocation()
           centerMapView()
        locationManager.stopUpdatingLocation()
          
       }
   }
       private func centerMapView() {
           let mapMeterds: Double = 1_000
           
           guard let location = locationManager.location else {return}
           
           let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: mapMeterds, longitudinalMeters: mapMeterds)
           
           map1.setRegion(region, animated: true)
       }
    private func addAnnotations(lat1: Double, lon1: Double, name: String, sub: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat1)!, longitude: CLLocationDegrees(exactly: lon1)!)
        annotation.title = name
        annotation.subtitle = sub
        self.map1.addAnnotation(annotation)
    }
    func showRouteOnMap(destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location!.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            if (unwrappedResponse.routes.count > 0) {
                self.map1.addOverlay(unwrappedResponse.routes[0].polyline)
                self.map1.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
                
            }
        }
    }}


extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        showRouteOnMap(destination: view.annotation!.coordinate)
    }
    func mapView( _ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
                var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
  
}

