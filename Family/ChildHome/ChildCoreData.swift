//
//  ChildCoreData.swift
//  Father
//
//  Created by Maher on 9/12/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import CoreData


class ChildLocations  {
    
    
    var lat : Double?
    var long : Double?
    var email : String?
    var ChildArray : [ChildModel] = []
    var context:NSManagedObjectContext!
    
    
    
    
    func openDatabse()
    {
        context = ad.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Address", in: context)
        if let email = UserDefaults.standard.value(forKey: "email") as? String {
                        self.email = email
                    }
        if checkAccount(email : self.email!) {
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            saveData(UserDBObj:newUser)
        }else{
            editData()
        }
        
    }
    
    
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func saveData(UserDBObj:NSManagedObject)
    {
        
        UserDBObj.setValue(self.email, forKey: "email")
        UserDBObj.setValue(self.lat, forKey: "lat")
        UserDBObj.setValue(self.long, forKey: "long")
      //  UserDBObj.setValue(self.email, forKey: "name")
        
        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
        
        fetchData()
    }
    
    
    func editData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let email2 = data.value(forKey: "email") as! String
                if email == email2 {
                    data.setValue(self.lat, forKey: "lat")
                    data.setValue(self.long, forKey: "long")
                    do {
                        try context.save()
                        fetchData()
                        return
                    } catch {
                        print("Storing data Failed")
                    }
                }
            }
        } catch {
            print("Fetching data Failed")
        }
        
    }
    
    func checkAccount (email : String) ->Bool{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let email2 = data.value(forKey: "email") as? String{
                    if email == email2 {
                        
                        return false
                    }
                }
            }
        } catch {
            print("Fetching data Failed")
        }
        return true
    }
    
    
    
    
    
    func fetchData()
    {
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let email = data.value(forKey: "email") as! String
                let lat = data.value(forKey: "lat") as! Double
                let long = data.value(forKey: "long") as! Double
                self.ChildArray.append(ChildModel(data: data))
                
                print("User Name is : \(email)"+" and Age is : \(lat) ")
            }
            print(self.ChildArray)
        } catch {
            print("Fetching data Failed")
        }
    }
}
