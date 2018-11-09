//
//  FREditUserPresenter.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation

protocol FREditUserOutput: class {
    func viewReady()
    func emailChanged(newEmail: String) -> Bool
    func firstNameChanged(newFirstName: String) -> Bool
    func lastNameChanged(newFirstName: String) -> Bool
    
    func saveButtonTapped()
    
}

class FREditUserPresenter: FREditUserOutput {
    weak var view: FREditUserInputView!
    weak var router: FREditUserRouter!
    var service: FRUsersService!
    var selectedCellObject: FRBaseCellObject!
    var newModel: FRUserModel!
    
    
    //MARK: - FREditUserOutput
    func viewReady() {
        guard let userCellObject = selectedCellObject as? FRUserCellObject else { fatalError() }
        view.setSelectedUser(with: userCellObject.firstName, lastName: userCellObject.lastName, email: userCellObject.email, avatarURL: userCellObject.avatarURL)
        newModel = FRUserModel()
        newModel.email = userCellObject.email ?? ""
        newModel.first_name = userCellObject.firstName ?? ""
        newModel.last_name = userCellObject.lastName ?? ""
        newModel.id = userCellObject.id
        newModel.avatar_url = userCellObject.avatarURL
    }
    
    func emailChanged(newEmail: String) -> Bool {
        newModel.email = newEmail
        return validateData()
    }
    
    func firstNameChanged(newFirstName: String) -> Bool {
        newModel.first_name = newFirstName
        return validateData()
    }
    
    func lastNameChanged(newFirstName: String) -> Bool {
        newModel.last_name = newFirstName
        return validateData()
    }
    
    func saveButtonTapped() {
        service.saveUser(model: newModel, index: newModel.id, success: { [weak self] in
            self?.router.closeView()
        }) { [weak self] in
            self?.view.showErrorPopUp(with: kErrorTitle, and: kErrorMessage)
        }
    }
    
    //MARK: - Private
    private func validateData() -> Bool {
        
        guard let email = newModel.email, let firstName = newModel.first_name, let lastName = newModel.last_name else { return false }
        
        if firstName.count < 1 {
            return false
        }
        
        if lastName.count < 1 {
            return false
        }
        
        do {
            let range = NSMakeRange(0, email.count)
            let regularCheck = try! NSRegularExpression(pattern: regularPattern, options: .caseInsensitive)
            let result = regularCheck.firstMatch(in: email, options: [], range: range)
            return result?.range == range && result != nil
        } catch {
            return false
        }

    }
    
}
