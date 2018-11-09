//
//  FRUserListFactory.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation

class FRUserListFactory {
    
    func userCellObject(from models: [FRUserModel]) -> [FRBaseCellObject] {
        var cellObjects: [FRBaseCellObject] = []
        for user in models {
            let cellObject = FRUserCellObject()
            cellObject.firstName = user.first_name ?? ""
            cellObject.lastName = user.last_name ?? ""
            cellObject.avatarURL = user.avatar_url
            cellObject.email = user.email
            cellObject.id = user.id
            cellObjects.append(cellObject)
        }
        return cellObjects
    }
    
}
