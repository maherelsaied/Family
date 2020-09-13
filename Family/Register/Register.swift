//
//  Register.swift
//  Father
//
//  Created by Maher on 9/9/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import Firebase


class Register: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    lazy var viewModel: RegisterVM = {
        return RegisterVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewModelAction()
        
    }
    
    
    func registerViewModelAction (){
        viewModel.getDataClosure = {  [weak self] () in
            guard let self = self else {return}
            self.viewModel.email = self.emailTF.text!
            self.viewModel.pass = self.passTF.text!
            self.viewModel.userName = self.userNameTF.text
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
    
    @IBAction func registerAction(_ sender: Any) {
        viewModel.createAccount()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
}
