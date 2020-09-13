//
//  homeVC.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit
import CoreData

class homeVC: UIViewController {

    var ChildArray : [ChildModel] = []
    var context:NSManagedObjectContext!
    lazy var viewModel: HomeViewModel = {
             return HomeViewModel()
         }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HometableCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData { (state, data) in
            guard state else {return}
            if let data = data {
                self.ChildArray = data
                self.tableView.reloadData()
            }
        }
     //  viewModel.deleteAllRecords()
        
    }


    @IBAction func addSon(_ sender: Any) {
        let vc = AddChild()
          vc.modalTransitionStyle = .crossDissolve
          vc.modalPresentationStyle = .overFullScreen
          vc.delgate = self
          self.present(vc, animated: true, completion: nil)
    }
    

}


extension homeVC : UITableViewDelegate , UITableViewDataSource , AddChildProtocol {
    func addChild(ifSon: Bool) {
        if ifSon {
            viewModel.fetchData { (state, data) in
                guard state else {return}
                if let data = data {
                    self.ChildArray = data
                    self.tableView.reloadData()
                }
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ChildArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HometableCell
        cell.childImg.image = UIImage(named: "family")
        cell.childName.text = ChildArray[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}


