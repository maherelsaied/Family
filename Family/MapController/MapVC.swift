//
//  MapVC.swift
//  Father
//
//  Created by Maher on 9/12/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
      var locationManager = CLLocationManager()
      var currentLocation: CLLocation?
      var zoomLevel: Float = 15.0
      let marker = GMSMarker()
      var ChildArray : [ChildModel] = []
      var context:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGoogleLocation()
        getChildLocation()
    }
    
    func setupGoogleLocation() {
        mapView.isMyLocationEnabled = true
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
   
    }
    
    
    func showMarker(position: CLLocationCoordinate2D){
          marker.position = position
        //  marker.icon = UIImage(named: "pin-1")
          marker.isDraggable=true
          marker.map = mapView
      }
    
 
    
    func getChildLocation() {
     
  
               print("Fetching Data..")
               context = ad.persistentContainer.viewContext
               let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
               request.returnsObjectsAsFaults = false
               do {
                   let result = try context.fetch(request)
                   self.ChildArray.removeAll()
                   for data in result as! [NSManagedObject] {
                       
                       let email = data.value(forKey: "email") as! String
                       let lat = data.value(forKey: "lat") as! Double
                       let long = data.value(forKey: "long") as! Double
                       let Name = data.value(forKey: "name") as? String
                   //    showMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: long) )
                       
                    
                    let emailf = data.value(forKey: "fathremail") as? String
                                     if let email = UserDefaults.standard.value(forKey: "email") as? String {
                                                   
                                       if email == emailf {
                                            self.ChildArray.append(ChildModel(data: data))
                                       }
                                        
                    }
                       print("User Name is : \(email)"+" and Age is : \(lat) ")
                   }
                   print(self.ChildArray)
               } catch {
                   print("Fetching data Failed")
               }
           }

}

extension MapVC : CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
     
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
           mapView.camera = camera
            let myLocation = location
        
        
        for data in ChildArray{
            let location = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
               print("location: \(location)")
               let marker = GMSMarker()
               let myBuddysLocation = CLLocation(latitude: data.lat, longitude: data.long)
               let distance = myLocation.distance(from: myBuddysLocation)/1000
               if distance > 1 {
                marker.icon = GMSMarker.markerImage(with: UIColor.red)
               }else{
                marker.icon = GMSMarker.markerImage(with: UIColor.green)
                }
               
               marker.position = location
               marker.snippet = data.name
               marker.map = mapView
           }
       
        }
    }
    
    


