//
//  ViewController.swift
//  LocationAware
//  Mini project from Udemy (iOS10 & Swift 3 complete developer) course
//
//  Created by admin on 05/01/2018.
//  Copyright © 2018 Josh_Dog101. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate        = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        self.latitudeLabel.text  = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        self.courseLabel.text    = String(location.course)
        self.speedLabel.text     = String(location.speed)
        self.altitudeLabel.text  = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placements, error) in
            if error != nil {
                print (error ?? "unknown error")
            } else {
                if let placemark = placements?[0] {
                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil {
                        address += placemark.country! + "\n"
                    }
                    self.addressLabel.text = address
                }
            }
        }
    }
}
