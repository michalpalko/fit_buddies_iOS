//
//  User.swift
//  Fit Buddies
//
//  Created by Michal Palko on 28/12/2020.
//

import Foundation
import UIKit

struct User {
    var uid : String
    var name : String
    var email : String
    var password : String?
    var photo : UIImage?
    var tips : [Tip]
    
    init(with uid:String, name:String, email:String,password:String?, photo:UIImage?, tips:[Tip]) {
        self.uid = uid
        self.name = name
        self.email = email
        self.password = password
        self.photo = photo
        self.tips = tips
    }
    
    func addTip(_:Tip) {
        //here goes firebase firestore implementation code for adding new tip from the current user
    }
    
    func likeTip(with id: String){
        //here goes firebase update tip implementation
    }
    
    func updatePassword(oldPassword:String, newPassword:String){
    }
    
    
    
}
