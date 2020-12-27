//
//  BodyPartsViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 26/12/2020.
//

import Foundation
import UIKit
import Firebase

class BodyPartsViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

}
