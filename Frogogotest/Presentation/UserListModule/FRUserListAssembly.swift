//
//  FRUserListAssembly.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

class FRUserListAssembly {
    
    func buildModule() -> UIViewController {
        let viewController = UIStoryboard(name: "FRUserList", bundle: nil).instantiateViewController(withIdentifier: "FRUserViewController") as! FRUserViewController
        let presenter = FRUserListPresenter()
        
        viewController.output = presenter
        presenter.router = viewController
        presenter.view = viewController
        presenter.service = FRUsersServiceAssembly().buildService()
        presenter.factory = FRUserListFactory()
        return viewController
    }
    
}
