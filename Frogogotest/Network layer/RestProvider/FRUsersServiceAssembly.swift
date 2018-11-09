//
//  PGUsersServiceAssembly.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation

class FRUsersServiceAssembly {
    
    func buildService() -> FRUsersService {
        let provider = FRUsersServiceImplementation()
        return provider
    }
    
}
