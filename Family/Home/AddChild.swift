//
//  AddChild.swift
//  Father
//
//  Created by Maher on 9/12/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import CoreData


protocol AddChildProtocol : class {
    func addChild (ifSon : Bool)
}

class AddChild: UIViewController {

    
    
    var ChildArray : [ChildModel] = []
    var myChild : [ChildModel] = []
    var lat : Double = 0.0
    var long : Double = 0.0
    weak var delgate : AddChildProtocol!
    var searchEmail : String?
    var context:NSManagedObjectContext!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    
    lazy var viewModel: ChildLocations = {
            return ChildLocations()
        }()
    @IBAction func addChild(_ sender: Any) {
      
        guard let email = self.email.text , !email.isEmpty else {
            self.showAlert(title: "error", detail: "Enter Data", vc: self)
            return}
        guard let name = self.name.text , !name.isEmpty else{
            self.showAlert(title: "error", detail: "Enter Data", vc: self)
            return}
    
        if checkEmailIfFound(email: email) && editData(){
               let entity = NSEntityDescription.entity(forEntityName: "Father", in: context)
               let newUser = NSManagedObject(entity: entity!, insertInto: context)
               
               newUser.setValue(email, forKey: "email")
               newUser.setValue(self.lat, forKey: "lat")
               newUser.setValue(self.long, forKey: "long")
               newUser.setValue(name, forKey: "name")
               if let email = UserDefaults.standard.value(forKey: "email") as? String {
                          newUser.setValue(email, forKey: "fathremail")
                        }
               
               
               print("Storing Data..")
               do {
                   try context.save()
               } catch {
                   print("Storing data Failed")
               }
             
            let entity2 = NSEntityDescription.entity(forEntityName: "Address", in: context)
                         let newUser2 = NSManagedObject(entity: entity2!, insertInto: context)
                         
                         newUser2.setValue(email, forKey: "email")
                         newUser2.setValue(self.lat, forKey: "lat")
                         newUser2.setValue(self.long, forKey: "long")
                         newUser2.setValue(name, forKey: "name")
                         if let email = UserDefaults.standard.value(forKey: "email") as? String {
                                    newUser.setValue(email, forKey: "fathremail")
                                  }
                         
                         
                         print("Storing Data..")
                         do {
                             try context.save()
                         } catch {
                             print("Storing data Failed")
                         }
            
            
            
            
               
               self.delgate.addChild(ifSon: true)
               self.dismiss(animated: true, completion: nil)
            
        }else{
            self.showAlert(title: "Error", detail: "NotFound", vc: self)
            return
        }
    }

    
    func editData()-> Bool{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Father")
        request.returnsObjectsAsFaults = false
        editAddress()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let email2 = data.value(forKey: "email") as! String
                if self.email.text! == email2 {
                    data.setValue(email2, forKey: "email")
                    data.setValue(self.lat, forKey: "lat")
                    data.setValue(self.long, forKey: "long")
                    data.setValue(self.name.text!, forKey: "name")
                    if let email = UserDefaults.standard.value(forKey: "email") as? String {
                                            data.setValue(email, forKey: "fathremail")
                                          }
                    
                    do {
                        try context.save()
                        self.delgate.addChild(ifSon: true)
                        self.dismiss(animated: true, completion: nil)
                        return false
                        //fetchData()
                       // return
                    } catch {
                        print("Storing data Failed")
                    }
                }
            }
            
        } catch {
            print("Fetching data Failed")
        }
        return true
        
    }
    func editAddress(){
       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
              request.returnsObjectsAsFaults = false
              do {
                  let result = try context.fetch(request)
                  for data in result as! [NSManagedObject] {
                      let email2 = data.value(forKey: "email") as! String
                      if self.email.text! == email2 {
                          data.setValue(email2, forKey: "email")
                          data.setValue(self.lat, forKey: "lat")
                          data.setValue(self.long, forKey: "long")
                          data.setValue(self.name.text!, forKey: "name")
                          if let email = UserDefaults.standard.value(forKey: "email") as? String {
                                                  data.setValue(email, forKey: "fathremail")
                                                }
                          do {
                              try context.save()
//                              self.delgate.addChild(ifSon: true)
//                              self.dismiss(animated: true, completion: nil)
                              return
                              //fetchData()
                             // return
                          } catch {
                              print("Storing data Failed")
                          }
                      }
                  }
                  
              } catch {
                  print("Fetching data Failed")
              }
              

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    
    func fetchData()
    {
        context = ad.persistentContainer.viewContext

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
    
    func checkEmailIfFound (email : String) -> Bool {
        for x in ChildArray {
      
            if x.email == email  {
               
                self.lat = x.lat
                self.long = x.long
                return true
            }
            
        }
        return false
    
    }
}
