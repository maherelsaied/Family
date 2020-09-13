//
//  AlertC.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit

extension UIViewController {
     func showAlert (title : String , detail : String , vc : UIViewController ) {
        let alertController = UIAlertController(title: title, message: detail, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "ok", style: .default) { (_) in
            
        }
        alertController.addAction(okBtn)
        vc.present(alertController, animated: true, completion: nil)
    }

}
