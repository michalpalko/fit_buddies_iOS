//
//  ExercisesViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 06/01/2021.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class ExercisesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    var exercisesArray = Array<Exercise>()
    var selectedExercise : Exercise?
    var bodyPartid = ""
    var subBodyPartTitle = ""
    var subBodyPartId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = subBodyPartTitle
        
        if let myCreds = UserDefaults.standard.string(forKey: "user_uid_key") {
            print(myCreds.description)
        }
        
        if let email = Auth.auth().currentUser?.email {
            print("EMAIL : \(email)")
        }
        
        let nib = UINib(nibName: "ExerciseCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: Strings.Identifiers.exercise_cell)
        
        loadExercises()
    }
    
    private func loadExercises(){
        db.collection(Strings.Firestore.BodypartsCollection).document(bodyPartid).collection(Strings.Firestore.SubBodypartsCollection).document(subBodyPartId).collection(Strings.Firestore.ExercisesCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("ERROR LOADING DOCUMENTS: \(e.localizedDescription)")
            } else {
                print("COLLECTION PATH \(self.db.collection(Strings.Firestore.BodypartsCollection).document(self.bodyPartid).collection(Strings.Firestore.SubBodypartsCollection).document(self.subBodyPartId).collection(Strings.Firestore.ExercisesCollection))")
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        if let title = data["title"] as? String, let baseDescription = data["baseDescription"] as? String, let imageUrl = data["imageUrl"] as? String{
                            print("PART TITLE: \(title), PART URL: \(imageUrl)")
                            let exercise = Exercise(id: document.documentID, title: title, baseDescription: baseDescription, imageUrl: imageUrl)
                            self.exercisesArray.append(exercise)
                            DispatchQueue.main.async {
                                self.collectionView?.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ExercisesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.Identifiers.exercise_cell, for: indexPath) as! ExerciseCollectionViewCell
        cell.exerciseTitle.text = exercisesArray[indexPath.row].title
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("exercises/\(exercisesArray[indexPath.row].imageUrl)")
        
        let placeholder = UIImage(systemName: "photo.fill")
        imageRef.downloadURL {(url, error) in
            if let e = error {
                print("ERROR URL: \(e)")
            } else {
                if let imageUrl = url?.absoluteString {
                    cell.exercisesImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholder)
                }
            }
        }
        return cell
    }
}

extension ExercisesViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
