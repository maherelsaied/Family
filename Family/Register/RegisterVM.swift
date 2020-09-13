//
//  RegisterVM.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import Firebase

class RegisterVM {
    var getDataClosure : (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    var email : String?
    var pass : String?
    var userName : String?
    
    var alertMessage : String?{
        didSet{
            self.showAlertClosure?()
        }
    }
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    //valiudation
    func validateRows ()->Bool{
        guard let email = email , email != "" else{
            if self.email == "" {
                alertMessage = "Enter your mail"
            }
            return false
        }
        guard let name = userName , name != "" else{
            if self.userName == "" {
                alertMessage = "Enter your Name"
            }
            return false
        }
        if self.pass == "" {
            alertMessage = "Enter your password"
            return false
        }
        guard let pass = pass ,pass != "", pass.count >= 8 , pass.count <= 15 else{
            alertMessage = "Weak passsword"
            return false
        }
        return true
    }
    
    //  Register Api
    func createAccount() {
        self.getDataClosure?()
        guard let email = email , let pass = pass , let userName = userName else {return}
        guard validateRows()else{return}
        state = .loading
        
        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                self.state = .error
                self.alertMessage = error.localizedDescription
                ad.killLoading()
                return
            }
            let values = ["email" : email , "userName" : userName]
            guard let uid = result?.user.uid else{return}
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                if let error = error {
                    self.state = .error
                    self.alertMessage = error.localizedDescription
                    ad.killLoading()
                    return
                }
                print("ok done register")
                self.state = .populated
                UserDefaults.standard.set(self.email, forKey: "email")
            }
            
        }
    }
    
}
