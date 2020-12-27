//
//  ViewController.swift
//  Fit Buddies
//
//  Created by Michal  on 05/12/2020.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    private let segues = Strings.Segues.init()
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                    UserDefaults.standard.synchronize()
                    let mainTabBarController = self.storyboard?.instantiateViewController(identifier: "MainTabBarController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController!)
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: segues.segue_loginToRegistration , sender: self)
    }
    
}
