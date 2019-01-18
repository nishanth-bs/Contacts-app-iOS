//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

//protocol contain shouldn't contain delegate
protocol CreateNameDelegateProtocol {
    func userCreatedName(enteredData: Person) -> Bool
}

class AddContactViewController: UIViewController {

    @IBOutlet weak var addFirstName: UITextField!
    @IBOutlet weak var addLastName: UITextField!
    @IBOutlet weak var addPhoneNumber: UITextField!
    @IBOutlet weak var addEmail: UITextField!
    
    //delegate name to be suffixed with delegate
    var createdName: CreateNameDelegateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEmail.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createButtonPressed(_ sender: UIButton) {
        let firstName = addFirstName.text!
        let lastName = addLastName.text!
        let phoneNumber = addPhoneNumber.text!
        
        let enteredData = Person(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        
        if let success = createdName?.userCreatedName(enteredData: enteredData){
            if success{
                let alert = UIAlertController(title: "Success!", message: "Contact added", preferredStyle: UIAlertControllerStyle.alert)
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
                let alert = UIAlertController(title: "Error!", message: "Contact not added! Please check again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
