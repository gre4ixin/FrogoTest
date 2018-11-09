//
//  UserModel.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation


struct FRUserModel: Codable {
    var id: Int!
    var first_name: String?
    var last_name: String?
    var email: String?
    var avatar_url: String?
}
