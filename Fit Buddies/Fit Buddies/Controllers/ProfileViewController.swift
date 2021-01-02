//
//  ProfileViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 27/12/2020.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var handle: AuthStateDidChangeListenerHandle?
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var user = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                //              let uid = user.uid
                let email = user.email
                let name = user.displayName
                //var multiFactorString = "MultiFactor: "
                //          for info in user.multiFactor.enrolledFactors {
                //            multiFactorString += info.displayName ?? "[DispayName]"
                //            multiFactorString += " "
                //          }
                
                
                if let photoURL = user.photoURL {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: photoURL)
                        DispatchQueue.main.async {
                            self.profilePictureImageView.image = UIImage(data: data!)
                        }
                    }
                }
                self.nameLabel.text = name
                self.emailLabel.text = email
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func LogOutButtonTapped(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        GIDSignIn.sharedInstance().signOut()
        
        do {
            try firebaseAuth.signOut()
            let loginNavController = self.storyboard?.instantiateViewController(identifier: "LoginNavigationController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController!)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
