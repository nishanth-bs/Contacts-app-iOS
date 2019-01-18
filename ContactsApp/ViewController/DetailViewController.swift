//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

protocol UpdateNameDelegateProtocol {
    func userUpdatedName(name: String)
}

class DetailViewController: UIViewController {
    var contactName: String = ""
    var contactPhoneNumber: String = ""
    var contactLastName : String = ""
    var editable: Bool = false
    var selectedIndexRow: Int = 0
    
   
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //lastnameTextField.text = contactNamesList[selectedRow]
        firstnameTextField.text =  contactName
        lastnameTextField.text = contactLastName
        phoneNumberTextField.text = contactPhoneNumber
        
        lastnameTextField.isEnabled = false
        firstnameTextField.isEnabled = false
        phoneNumberTextField.isEnabled = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        lastnameTextField.isEnabled = true
        firstnameTextField.isEnabled = true
        phoneNumberTextField.isEnabled = true
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        if let firstName = firstnameTextField.text{
            let enteredData : Person = Person(firstName: firstName, lastName: lastnameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        }
        
        let enteredData : Person = Person(firstName: firstnameTextField.text, lastName: lastnameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        
        if DataModel.updateAt(position: selectedIndexRow, enteredData: enteredData){
            //show success
            let alert = UIAlertController(title: "Success!", message: "Contact updated", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
        }else{
            let alert = UIAlertController(title: "Error!", message: "Contact not updated! Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
//        DataModel.dataModel[selectedIndexRow].firstName = firstnameTextField.text!
//        DataModel.dataModel[selectedIndexRow].lastName = lastnameTextField.text!
//        navigationController?.popViewController(animated: true)
//        print(DataModel.dataModel[selectedIndexRow].firstName)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        if DataModel.removeAt(position: selectedIndexRow){
            //show Success and go back
            //show success
            let alert = UIAlertController(title: "Success!", message: "Contact deleted", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
            
        }else{
            //show error and stay
            let alert = UIAlertController(title: "Error!", message: "Contact not deleted! Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       // DataModel.dataModel.remove(at: selectedIndexRow)
       // navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func goBackButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
