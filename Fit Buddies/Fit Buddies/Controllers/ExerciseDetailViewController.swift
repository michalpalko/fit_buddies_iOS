//
//  ViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 09/01/2021.
//

import UIKit
import Firebase
import Foundation
import SDWebImage

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var baseExerciseImageView: UIImageView!
    
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    var subBodyPartId = ""
    var bodyPartid = ""
    var exercise : Exercise?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = exercise?.title
        
        if let myCreds = UserDefaults.standard.string(forKey: "user_uid_key") {
            print(myCreds.description)
        }
        
        if let email = Auth.auth().currentUser?.email {
            print("EMAIL : \(email)")
        }
        
        loadImage()
        descriptionLabel.text = exercise?.baseDescription

    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    private func loadImage(){
        if let actualExercise = exercise {
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child("exercises/\(actualExercise.imageUrl)")
            
            let placeholder = UIImage(systemName: "photo.fill")
            imageRef.downloadURL {(url, error) in
                if let e = error {
                    print("ERROR URL: \(e)")
                } else {
                    if let imageUrl = url?.absoluteString {
                        self.baseExerciseImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholder)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.Segues.segue_exerciseDetailToTips {
            if let tipsViewController = segue.destination as? TipsViewController{
                
            }
        }
        if segue.identifier == Strings.Segues.segue_exerciseDetailToAddTip {
            //if let addTipViewController = segue.destination as? Add
        }
    }
    
    @IBAction func showTipsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Strings.Segues.segue_exerciseDetailToTips, sender: self)
    }
    
    @IBAction func addNewTipButtonTapped(_ sender: UIBarButtonItem) {
    }
    
}
