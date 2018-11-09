//
//  FREditUserAssembly.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

class FREditUserParameters {
    var selectedCellObject: FRBaseCellObject!
}

class FREditUserAssembly {
    func buildModule(with parameters: FREditUserParameters) -> UIViewController {
        let viewController = UIStoryboard(name: "FREditUser", bundle: nil).instantiateViewController(withIdentifier: "FREditUserController") as! FREditUserController
        
        let presenter = FREditUserPresenter()
        presenter.view = viewController
        presenter.router = viewController
        presenter.selectedCellObject = parameters.selectedCellObject
        presenter.service = FRUsersServiceAssembly().buildService()
        viewController.output = presenter
        return viewController
    }
}
