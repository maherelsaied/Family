//
//  ChildHome.swift
//  Child
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import CoreData

class ChildHome: UIViewController , CLLocationManagerDelegate{

   
    var locationManager: CLLocationManager!
    var lat : Double?
    var long : Double?
    var email : String?
    var ChildArray : [ChildModel] = []
    var context:NSManagedObjectContext!
    lazy var viewModel: ChildLocations = {
          return ChildLocations()
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = UserDefaults.standard.value(forKey: "email") as? String {
                 self.email = email
             }
      setLocation ()

    }
    @IBAction func logOut(_ sender: Any) {
        do {
                  try Auth.auth().signOut()
                  UserDefaults.standard.set(nil, forKey: "email")
                  ad.restartApplication()
                  
              }catch let error {
                  print(error.localizedDescription)
              }
    }
    

    func setLocation () {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation

        if self.lat == nil {
            self.lat = location.coordinate.latitude
            self.long = location.coordinate.longitude
            viewModel.lat = self.lat
            viewModel.long = self.long
            viewModel.openDatabse()

        }
    }

}
