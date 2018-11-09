//
//  PGUserCell.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit
import Alamofire

protocol BaseCellProtocol {
    func configure(with cellObject: FRBaseCellObject)
}

class FRUserCell: UITableViewCell, BaseCellProtocol {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLable: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with cellObject: FRBaseCellObject) {
        guard let cellObject = cellObject as? FRUserCellObject else { fatalError() }
        setUserInfo(firstName: cellObject.firstName!, lastName: cellObject.lastName!, email: cellObject.email!)
        uploadAvatar(urlString: cellObject.avatarURL ?? "")
    }
    
    private func setUserInfo(firstName: String, lastName: String, email: String) {
        firstNameLabel.text = firstName
        lastNameLable.text = lastName
        emailLabel.text = email
    }
    
    private func uploadAvatar(urlString: String) {
        if ((urlString == nil) || (urlString.count == 0)) {
            return
        }
        request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { [weak self] (response) in
            guard let imageData = response.data else { return }
            self?.avatarImageView.image = UIImage(data: imageData)
        }
    }
    
}
