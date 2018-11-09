//
//  FRUserListPresenter.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation


protocol FRUserOutput: class {
    func viewReady()
    
    func didSelectedCell(with indexPath: IndexPath)
    
    func updateUsers()
    
}

let kErrorMessage = "Попробуйте повторить позже"
let kErrorTitle = "Ошибка"

class FRUserListPresenter: FRUserOutput {
    weak var view: FRUserInputView!
    weak var router: FRUserRouter!
    var service: FRUsersService!
    var factory: FRUserListFactory!
    
    var userCellObjects: [FRBaseCellObject] = []
    
    func viewReady() {
        view.showProgressHud()
        service.obtainUsers(success: { [weak self] (response) in
            let cellObjects = self?.factory.userCellObject(from: response)
            self?.view.updateCellObjects(with: cellObjects!)
            self?.userCellObjects = cellObjects!
            self?.view.hideProgressHud()
        }) { [weak self] in
            self?.view.showErrorPopUp(with: kErrorTitle, and: kErrorMessage)
            self?.view.hideProgressHud()
        }
    }
    
    
    func didSelectedCell(with indexPath: IndexPath) {
        let selectedUser = userCellObjects[indexPath.row]
        router.showEditView(with: selectedUser)
    }
    
    func updateUsers() {
        service.obtainUsers(success: { [weak self] (response) in
            let cellObjects = self?.factory.userCellObject(from: response)
            self?.view.updateCellObjects(with: cellObjects!)
            self?.userCellObjects = cellObjects!
            self?.view.hideProgressHud()
            self?.view.stopRefresh()
        }) { [weak self] in
            self?.view.showErrorPopUp(with: kErrorTitle, and: kErrorMessage)
            self?.view.stopRefresh()
        }
    }
}
