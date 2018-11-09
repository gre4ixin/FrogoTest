//
//  FRUserViewController.swift
//  Frogogotest
//
//  Created by Pavel Grechikhin on 08/11/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

protocol FRUserRouter: class {
    func showEditView(with cellObject: FRBaseCellObject)
}

protocol FRUserInputView: class {
    func updateCellObjects(with cellObjects: [FRBaseCellObject])
    func showErrorPopUp(with title: String, and message: String)
    
    func showProgressHud()
    func hideProgressHud()
    func stopRefresh()
}

class FRUserViewController: UIViewController, FRUserRouter, FRUserInputView {
    
    var output: FRUserOutput!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var refreshControll = UIRefreshControl()
    
    var cellObjects: [FRBaseCellObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Список пользователей"
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.isHidden = true
        tableView.register(FRUserCellObject().nib, forCellReuseIdentifier: FRUserCellObject().identifier)
        output.viewReady()
        refreshControll.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        tableView.addSubview(refreshControll)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showCreatingView)), animated: true)
    }
    
    
    //MARK: - FRUserInputView
    func updateCellObjects(with cellObjects: [FRBaseCellObject]) {
        self.cellObjects = cellObjects
        tableView.reloadData()
    }
    
    func showErrorPopUp(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgressHud() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideProgressHud() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func stopRefresh() {
        refreshControll.endRefreshing()
    }
    
    //MARK: - FRUserRouter
    
    func showEditView(with cellObject: FRBaseCellObject) {
        let parameters = FREditUserParameters()
        parameters.selectedCellObject = cellObject
        let vc = FREditUserAssembly().buildModule(with: parameters)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func showCreatingView() {
        let vc = FRCreateUserAssembly().buildModule()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func refreshed() {
        output.updateUsers()
    }
    
}

extension FRUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellObjects[indexPath.row].identifier) as? BaseCellProtocol
        cell?.configure(with: cellObjects[indexPath.row])
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellObjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellObjects[indexPath.row].height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output.didSelectedCell(with: indexPath)
    }
}
