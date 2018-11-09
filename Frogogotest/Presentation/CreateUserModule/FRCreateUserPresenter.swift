//
//  FRCreateUserPresenter.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import Foundation

protocol FRCreateUserOutput {
    func viewReady()
    func emailChanged(newEmail: String) -> Bool
    func firstNameChanged(newFirstName: String) -> Bool
    func lastNameChanged(newFirstName: String) -> Bool
    
    func saveButtonTapped()
}

let regularPattern = "([a-zA-Z0-9]){3,20}@([a-zA-Z0-9]){3,20}\\.([a-zA-Z]){1,7}"

class FRCreateUserPresenter: FRCreateUserOutput {
    weak var view: FRCreateInputView!
    weak var router: FRCreateUserRouter!
    var service: FRUsersService!
    
    var newModel: FRUserModel!
    
    func viewReady() {
        newModel = FRUserModel()
        newModel.id = 0
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
        service.createUser(model: newModel, success: { [weak self] in
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
