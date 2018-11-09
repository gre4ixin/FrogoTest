//
//  FREditUserController.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 09/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

protocol FREditUserRouter: class {
    func closeView()
}

protocol FREditUserInputView: class {
    func setSelectedUser(with name: String, lastName: String, email: String, avatarURL: String?)
    func showErrorPopUp(with title: String, and message: String)
}

class FREditUserController: UIViewController, FREditUserRouter, FREditUserInputView, UITextFieldDelegate {

    var output: FREditUserOutput!
    
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var invalidEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output.viewReady()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    
    private func setupView() {
        saveButton.isHidden = true
        invalidEmailLabel.isHidden = true
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    }
    
    //MARK: - FREditUserInputView
    
    func showErrorPopUp(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setSelectedUser(with name: String, lastName: String, email: String, avatarURL: String?) {
        firstNameTextField.text = name
        lastNameTextField.text = lastName
        emailTextField.text = email
        do {
            if (avatarURL != nil && avatarURL != "") {
                let unwrapAvatarUrl = avatarURL!
                avatarImageView.image = UIImage(data: try Data(contentsOf: URL(string: unwrapAvatarUrl)!))
            }
        } catch {
            
        }
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(textField:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldDidChange(textField:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
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
