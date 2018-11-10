//
//  PGUsersServiceImplementation.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation
import Moya


protocol FRUsersService {
    func obtainUsers(success: @escaping (_ response: [FRUserModel])->(), failure: @escaping ()->())
    func saveUser(model: FRUserModel, index: Int, success: @escaping () -> (), failure: @escaping () -> ())
    func createUser(model:FRUserModel, success: @escaping () -> (), failure: @escaping () -> ())
}

class FRUsersServiceImplementation: FRUsersService {
    
    private let provider = MoyaProvider<UsersListTarget>()
    
    func obtainUsers(success: @escaping (_ response: [FRUserModel])->(), failure: @escaping ()->()){
        provider.request(.usersList) { (result) in
            switch result {
            case .success(let response):
                let models = try! JSONDecoder().decode([FRUserModel].self, from: response.data)
                success(models)
            case .failure(_):
                failure()
                break;
            }
        }
    }
    
    func saveUser(model: FRUserModel, index: Int, success: @escaping () -> (), failure: @escaping () -> ()) {
        provider.request(.editUser(model, index)) { (result) in
            switch result {
            case .success(_):
                success()
            case .failure(_):
                failure()
            }
        }
    }
    
    func createUser(model: FRUserModel, success: @escaping () -> (), failure: @escaping () -> ()) {
        provider.request(.createUser(model)) { (result) in
            switch result {
            case .success(_):
                success()
            case .failure(_):
                failure()
            }
        }
    }
    
    
}
