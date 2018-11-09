//
//  FRUserListCellObject.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation
import UIKit

protocol FRBaseCellObject {
    var identifier: String { get }
    var nib: UINib { get }
    var height: Float { get }
}

class FRUserCellObject: FRBaseCellObject {
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var avatarURL: String?
    var id: Int!
    
    
    var identifier: String {
        return "FRUserCell"
    }
    
    var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var height: Float {
        return 90
    }
}
