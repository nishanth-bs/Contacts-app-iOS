//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

protocol UpdateNameProtocol {
    func userUpdatedName(position: Int, enteredData: Person) -> Bool
}

protocol DeleteNameProtocol {
    func userDeletedName(position: Int) -> Bool
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    
    //use optionals everywhere
    var currentPerson: Person?
    var editable: Bool?
    var selectedIndexRow: Int?
    var updatedNameProtocolDelegate: UpdateNameProtocol?
    var deletedNameProtocolDelegate: DeleteNameProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        disableTextFields()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialSetup(){
        firstnameTextField.text =  currentPerson?.firstName
        lastnameTextField.text = currentPerson?.lastName
        phoneNumberTextField.text = currentPerson?.phoneNumber
    }
    
    func disableTextFields(){
        lastnameTextField.isEnabled = false
        firstnameTextField.isEnabled = false
        phoneNumberTextField.isEnabled = false
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
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        lastnameTextField.isEnabled = true
        firstnameTextField.isEnabled = true
        phoneNumberTextField.isEnabled = true
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        if let firstName = firstnameTextField.text{
            let _ : Person = Person(firstName: firstName, lastName: lastnameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        }
        let enteredData : Person = Person(firstName: firstnameTextField.text!, lastName: lastnameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        if let indexRow = selectedIndexRow{
            if let success = updatedNameProtocolDelegate?.userUpdatedName(position: indexRow, enteredData: enteredData){
                if success{
                    //show success
                    showAlert(titleAction: "Success!", titleMessage: "Contact Updated", status: 0)
                }else{
                    //show error
                    showAlert(titleAction: "Error!", titleMessage: "Contact not updated! Please try again.", status: 1)
                }
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        if let a = selectedIndexRow{
            if let success = deletedNameProtocolDelegate?.userDeletedName(position: a){
                if success{
                    //show Success and go back
                    showAlert(titleAction: "Success!", titleMessage: "Contact deleted", status: 0)
                }else{
                    //show error and stay
                    showAlert(titleAction: "Error!", titleMessage: "Contact not deleted! Please try again.", status: 1)
                }
            }
        }
    }
    
    @IBAction func goBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
