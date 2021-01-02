//
//  BodyPartsViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 26/12/2020.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class BodyPartsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    var bodyPartsArray = Array<BodyPart>()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let myCreds = UserDefaults.standard.string(forKey: "user_uid_key") {
            print(myCreds.description)
        }
        
        if let email = Auth.auth().currentUser?.email {
        print("EMAIL : \(email)")
        }
        
        let nib = UINib(nibName: "BodyPartTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: Strings.Identifiers.bodyPart_cell)
        
        loadBodyParts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    private func loadBodyParts(){
        db.collection(Strings.Firestore.BodypartsCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("Error retrieving data from Firesore : \(e)")
            } else {
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        if let title = data["title"] as? String, let imageUrl = data["imageUrl"] as? String{
                            print("PART TITLE: \(title), PART URL: \(imageUrl)")
                            let bodyPart = BodyPart(title: title, image: imageUrl)
                            self.bodyPartsArray.append(bodyPart)
                            DispatchQueue.main.async {
                                self.tableView?.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension BodyPartsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyPartsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Identifiers.bodyPart_cell, for: indexPath) as! BodyPartTableViewCell
        cell.bodyPartTitle.text = bodyPartsArray[indexPath.row].title
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("bodyParts/\(bodyPartsArray[indexPath.row].image)")
        
        let placeholder = UIImage(systemName: "book.fill")
        imageRef.downloadURL {(url, error) in
            if let e = error {
                print("ERROR URL: \(e)")
            } else {
                if let imageUrl = url?.absoluteString {
//                    print("ABSOLUTE STRING: \(imageUrl)")
                    cell.bodyPartImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholder)
                }
            }
        }
        return cell
    }
}

extension BodyPartsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        return height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
