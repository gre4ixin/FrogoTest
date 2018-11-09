//
//  FRCreateUserViewController.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

protocol FRCreateUserRouter: class {
    func closeView()
}

protocol FRCreateInputView: class {
    func showErrorPopUp(with title: String, and message: String)
}

class FRCreateUserViewController: UIViewController, FRCreateUserRouter, FRCreateInputView {

    
    var output: FRCreateUserOutput!
    
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewReady()
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        setupView()
    }
    
    private func setupView() {
        saveButton.isHidden = true
        invalidEmailLabel.isHidden = true
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(textField:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldDidChange(textField:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldDidChange(textField:)), for: .editingChanged)
    }
    
    
    //MARK: - InputView
    
    func showErrorPopUp(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Router
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    @objc func emailTextFieldDidChange(textField: UITextField) {
        let valid = output.emailChanged(newEmail: textField.text ?? "")
        invalidEmailLabel.isHidden = valid
        saveButton.isHidden = !valid
    }
    
    @objc func firstNameTextFieldDidChange(textField: UITextField) {
        let valid = output.firstNameChanged(newFirstName: textField.text ?? "")
        invalidEmailLabel.isHidden = valid
        saveButton.isHidden = !valid
    }
    
    @objc func lastNameTextFieldDidChange(textField: UITextField) {
        let valid = output.lastNameChanged(newFirstName: textField.text ?? "")
        invalidEmailLabel.isHidden = valid
        saveButton.isHidden = !valid
    }
    
    @objc func saveButtonTapped(_ button: UIButton) {
        output.saveButtonTapped()
    }
    
    
    
}
