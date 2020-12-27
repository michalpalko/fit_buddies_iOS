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

        if let myCreds = UserDefaults.standard.string(forKey: "user_uid_key") {
            print(myCreds.description)
        }
        
        if let email = Auth.auth().currentUser?.email {
        print("EMAIL : \(email)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

}
