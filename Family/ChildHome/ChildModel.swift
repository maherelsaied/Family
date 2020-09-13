//
//  ChildModel.swift
//  Father
//
//  Created by Maher on 9/12/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import Foundation
import CoreData

struct ChildModel {
    private var email_ : String?
    private var lat_ : Double?
    private var long_ : Double?
    private var name_ : String?
    private var fathremail_ : String?
    
    
    var email : String {
        guard let x = email_ else { return "" }
        return x
    }
    var fatherEmail : String {
         guard let x = fathremail_ else { return "" }
         return x
     }
    var name : String {
          guard let x = name_ else { return "" }
          return x
      }
    var lat : Double {
        guard let x = lat_ else { return 0.0 }
          return x
      }
    var long : Double {
        guard let x = long_ else { return 0.0 }
          return x
      }
    
      
    
    
    init(data  : NSManagedObject) {
        self.email_ = data.value(forKey: "email") as? String
        self.lat_ = data.value(forKey: "lat") as? Double
        self.long_ = data.value(forKey: "long") as? Double
        self.name_ = data.value(forKey: "name") as? String
        self.fathremail_ = data.value(forKey: "fathremail") as? String
    }
}
