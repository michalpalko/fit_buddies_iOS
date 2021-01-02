//
//  SubBodyPart.swift
//  Fit Buddies
//
//  Created by Michal Palko on 28/12/2020.
//

import Foundation
import UIKit

struct SubBodyPart{
    var id:String
    var title:String
    var image:UIImage
    var bodypart:BodyPart
    var exercises:[Exercise]
    var tips:[Tip]
}
