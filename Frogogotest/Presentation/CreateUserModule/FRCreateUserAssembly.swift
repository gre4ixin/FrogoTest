//
//  FRCreateUserAssembly.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit


class FRCreateUserAssembly {
    
    func buildModule() -> UIViewController {
        
        let viewController = UIStoryboard(name: "FRCreateUser", bundle: nil).instantiateViewController(withIdentifier: "FRCreateUserViewController") as! FRCreateUserViewController
        
        let presenter = FRCreateUserPresenter()
        
        viewController.output = presenter
        presenter.router = viewController
        presenter.view = viewController
        presenter.service = FRUsersServiceAssembly().buildService()
        return viewController
    }
    
}
