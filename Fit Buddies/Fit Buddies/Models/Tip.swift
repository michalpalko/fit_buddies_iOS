//
//  Tip.swift
//  Fit Buddies
//
//  Created by Michal Palko on 28/12/2020.
//

import Foundation
import UIKit

struct Tip {
    var id:String
    var title:String
    var description:String
    
//    var startPositionImage:UIImage
//    var endPositionImage:UIImage
//
//    var video:URL
    var authorId:String
    var machine:Machine
    var aimedPart:BodyPart
    var aimedSubBodyPart:SubBodyPart
    var numberOfLikes:Int
    
    init(id:String, title:String, description:String, authorId:String, machine:Machine, aimedPart:BodyPart, aimedSubBodyPart:SubBodyPart) {
        self.id = id
        self.title = title
        self.description = description
        self.authorId = authorId
        self.machine = machine
        self.aimedPart = aimedPart
        self.aimedSubBodyPart = aimedSubBodyPart
        self.numberOfLikes = 0
    }
    
}
