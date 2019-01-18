//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

//protocol contain shouldn't contain delegate
protocol CreateNameProtocol {
    func userCreatedName(enteredData: Person) -> Bool
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var addFirstName: UITextField!
    @IBOutlet weak var addLastName: UITextField!
    @IBOutlet weak var addPhoneNumber: UITextField!
    @IBOutlet weak var addEmail: UITextField!
    
    var createdNameProtocolDelegate: CreateNameProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEmail.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(titleAction: String, titleMessage: String, status: Int){
        let alert = UIAlertController(title: titleAction, message: titleMessage, preferredStyle: UIAlertControllerStyle.alert)
        if status == 0{
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    self.navigationController?.popViewController(animated: true)
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
        }else if status == 1{
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let firstName = addFirstName.text!
        let lastName = addLastName.text!
        let phoneNumber = addPhoneNumber.text!
        
        let enteredData: Person = Person(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        
        if let success = createdNameProtocolDelegate?.userCreatedName(enteredData: enteredData){
            if success{
                showAlert(titleAction: "Success!", titleMessage: "Contact added", status: 0)
            }else{
                showAlert(titleAction: "Error!", titleMessage: "Contact not add! Please check again.", status: 1)
            }
        }
    }
}
