//
//  LoginVM.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import Firebase

public enum State {
    case loading
    case error
    case empty
    case populated
    
}


class LoginVM {
    
    var getDataClosure : (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var email : String?
    var pass : String?
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
    
    
    //Login Api
    func initLogin () {
        self.getDataClosure?()
        guard let email = email , let pass = pass else {return}
        guard validateRows()else{return}
        state = .loading
        Auth.auth().signIn(withEmail: email, password: pass) {(result, error) in
            if let error = error {
                print(error.localizedDescription)
                ad.killLoading()
                self.state = .error
                self.alertMessage = error.localizedDescription
                
                return
            }
            print("login done")
            self.state = .populated
            UserDefaults.standard.set(self.email, forKey: "email")
        }
        
    }
    
    
}
