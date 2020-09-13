//
//  HomeViewModel.swift
//  Father
//
//  Created by Maher on 9/13/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import CoreData


class HomeViewModel {
    
    
    
    var ChildArray : [ChildModel] = []
    var context:NSManagedObjectContext!
    
    
    
    
    func fetchData(completionHandler:@escaping (Bool,[ChildModel]?)->Void)
      {
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
                  let emailf = data.value(forKey: "fathremail") as? String
                  if let email = UserDefaults.standard.value(forKey: "email") as? String {
                                
                    if email == emailf {
                         self.ChildArray.append(ChildModel(data: data))
                    }
                
                }
                 
                  print("User Name is : \(emailf)"+" and Age is : \(lat) ")
              }
               completionHandler(true , self.ChildArray)
              print(self.ChildArray)
          } catch {
              print("Fetching data Failed")
            completionHandler(false , nil)
          }
      }

    
    func deleteAllRecords() {
          let delegate = UIApplication.shared.delegate as! AppDelegate
          let context = delegate.persistentContainer.viewContext
          
          let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Father")
          let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
          
          do {
              try context.execute(deleteRequest)
              try context.save()
          } catch {
              print ("There was an error")
          }
      }
}
