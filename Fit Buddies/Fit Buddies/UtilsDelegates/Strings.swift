//
//  Strings.swift
//  Fit Buddies
//
//  Created by Michal Palko on 26/12/2020.
//

import Foundation

struct Strings {
    struct Labels {
        static let login_welcome_label = "Hello, welcome to Fit buddies community! Please log in by e-mail and password used at registration, or via Google or Facebook account."
    }
    
    struct Segues {
        static let segue_loginToRegistration = "loginToRegisterSegue"
        static let segue_bodyToSubBodyParts = "bodyPartsToSubBodyPartsSegue"
        static let segue_subBodyPartToExercises = "subBodyPartToExercises"
        static let segue_exercisesToExerciseDetail = "exercisesToExerciseDetail"
        static let segue_exerciseDetailToTips = "exerciseDetailToTips"
        static let segue_exerciseDetailToAddTip = "exerciseDetailToAddTip"
    }
    
    struct Identifiers {
        static let bodyPart_cell = "bodypart_tv_cell"
        static let subBodyPart_cell = "subbodypart_tv_cell"
        static let exercise_cell = "exercisesCollectionViewCell"
        static let tip_cell = "tipTableViewCell"
    }
    
    struct Firestore {
        static let BodypartsCollection = "BodyParts"
        static let BodyPartsStorageRef = "bodyParts"
        static let SubBodypartsCollection = "SubBodyParts"
        static let SubBodyPartsStorageRef = "subBodyParts"
        static let ExercisesCollection = "Exercises"
        static let TipsCollection = "Tips"
    }
}


