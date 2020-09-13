//
//  Login.swift
//  Father
//
//  Created by Maher on 9/9/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import Firebase
class Login: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    lazy var viewModel: LoginVM = {
        return LoginVM()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModelAction ()
    }
    
    func loginViewModelAction (){
        viewModel.getDataClosure = {  [weak self] () in
            guard let self = self else {return}
            self.viewModel.email = self.emailTF.text!
            self.viewModel.pass = self.passTF.text!
        }
        viewModel.showAlertClosure = { [weak self] () in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if let message = self.viewModel.alertMessage {
                    self.showAlert(title: "Error", detail: message, vc: self)
                }
            }
        }
        viewModel.updateLoadingStatus = {[weak self] () in
            guard let self = self else {return}
            switch self.viewModel.state {
            case .error , .empty:
                ad.killLoading()
                DispatchQueue.main.async {
                    if let message = self.viewModel.alertMessage {
                        self.showAlert(title: "Error", detail: message, vc: self)
                    }
                }
            case .loading:
                ad.isLoading()
            case .populated :
                ad.killLoading()
                ad.goToHome()
                
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = Register()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        viewModel.initLogin()
    }
}
