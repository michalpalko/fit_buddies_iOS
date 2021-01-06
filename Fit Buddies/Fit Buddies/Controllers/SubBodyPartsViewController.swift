//
//  SubBodyPartsViewController.swift
//  Fit Buddies
//
//  Created by Michal Palko on 02/01/2021.
//
//MARK: - TODO: prepare for segue and perfrom segue to another screen
import UIKit
import Firebase
import SDWebImage

class SubBodyPartsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var subBodyParts = Array<SubBodyPart>()
    let db = Firestore.firestore()
    var bodyPartid = ""
    var titleLabel = ""
    var selectedSubBodyPart : SubBodyPart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleLabel
        self.tableView.tableFooterView = UIView()
        
        if let myCreds = UserDefaults.standard.string(forKey: "user_uid_key") {
            print(myCreds.description)
        }
        
        if let email = Auth.auth().currentUser?.email {
            print("EMAIL : \(email)")
        }
        
        let nib = UINib(nibName: "SubBodyPartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Strings.Identifiers.subBodyPart_cell)
        
        loadSubBodyParts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    private func loadSubBodyParts(){
        db.collection(Strings.Firestore.BodypartsCollection).document(bodyPartid).collection("SubBodyParts").getDocuments { (querySnapshot, error) in
            if let e = error {
                print("ERROR LOADING SUBBODYPARTS: \(e.localizedDescription)")
            }else {
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        if let title = data["title"] as? String, let imageUrl = data["image"] as? String{
                            print("SubPART TITLE: \(title), SubPART URL: \(imageUrl)")
                            let subBodyPart = SubBodyPart(id: document.documentID, title: title, image: imageUrl)
                            self.subBodyParts.append(subBodyPart)
                            DispatchQueue.main.async {
                                self.tableView?.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.Segues.segue_subBodyPartToExercises {
            if let exercisesVC = segue.destination as? ExercisesViewController {
                exercisesVC.bodyPartid = bodyPartid
                exercisesVC.subBodyPartId = selectedSubBodyPart!.id
                exercisesVC.subBodyPartTitle = selectedSubBodyPart!.title
            }
        }
    }
}

//MARK: TABLEVIEW EXTENSIONS
extension SubBodyPartsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subBodyParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Identifiers.subBodyPart_cell, for: indexPath) as! SubBodyPartTableViewCell
        cell.subBodyPartTitle.text = subBodyParts[indexPath.row].title
        
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("subBodyParts/\(subBodyParts[indexPath.row].image)")
        
        let placeholder = UIImage(systemName: "book.fill")
        imageRef.downloadURL {(url, error) in
            if let e = error {
                print("ERROR URL: \(e)")
            } else {
                if let imageUrl = url?.absoluteString {
                    //                    print("ABSOLUTE STRING: \(imageUrl)")
                    cell.subBodyPartImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholder)
                }
            }
        }
        return cell
    }
}
    
    extension SubBodyPartsViewController : UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            selectedSubBodyPart = subBodyParts[indexPath.row]
            performSegue(withIdentifier: Strings.Segues.segue_subBodyPartToExercises, sender: self)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    }
