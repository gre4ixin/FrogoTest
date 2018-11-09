//
//  UsersListProvider.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Moya

enum UsersListTarget {
    case usersList
    case editUser(FRUserModel, Int)
    case createUser(FRUserModel)
}

extension UsersListTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://bb-test-server.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .usersList:
            return "/users.json"
        case .editUser(_, let index):
            return "/users/\(index).json"
        case .createUser(_):
            return "users.json"
        }
    }
    
    var method: Method {
        switch self {
        case .usersList:
            return .get
        case .editUser:
            return .patch
        case .createUser(_):
            return .post
        }

    }
    
    var sampleData: Data {
        switch self {
        case .usersList:
            return "Запрос пользователей".data(using: String.Encoding.utf8)!
        case .editUser:
            return "".data(using: String.Encoding.utf8)!
        case .createUser(_):
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .usersList:
            return .requestPlain
        case .editUser(let model, _):
            let params = ["user": ["first_name" : model.first_name ?? "", "last_name":model.last_name ?? "", "email" : model.email ?? "", "avatar_url" : model.avatar_url ?? ""]]
            let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            return .requestData(data)
        case .createUser(let model):
            let params = ["user": ["first_name" : model.first_name ?? "", "last_name":model.last_name ?? "", "email" : model.email ?? "", "avatar_url" : ""]]
            let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            return .requestData(data)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}

