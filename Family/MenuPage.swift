//
//  HomePage.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import Firebase
class MenuPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            ad.restartApplication()
            UserDefaults.standard.set(nil, forKey: "email")
        }catch let error {
            print(error.localizedDescription)
        }
    }
   

}
