//
//  ViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateNameDelegateProtocol, DeleteNameDelegateProtocol, CreateNameDelegateProtocol {
    
    //MARK: IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    
    let a = Person(firstName: "raghavenra", lastName: "A", phoneNumber: "234-234-2345")
    let b = Person(firstName: "raghavendra", lastName: "A", phoneNumber: "234-234-2345")
    let c = Person(firstName: "raghavendran", lastName: "A", phoneNumber: "234-234-2345")
    var dataModel: [Person] = []
    
    var selectedRow = 0
    var selectedContactName : String = ""
    var selectedContactLastName: String = ""
    var selectedContactPhoneNumber: String = ""
    var selectedIndexRow: Int = 0
    
    //make functions simpler
    
    func userCreatedName(enteredData: Person) -> Bool {
        if Validation.isValidString(enteredData.firstName) &&
            Validation.isValidString(enteredData.lastName) &&
            Validation.isValidPhoneNumber(enteredData.phoneNumber) &&
            Validation.isNotDuplicate(dataModel,enteredData){
            dataModel.append(enteredData)
            return true
        }
        return false
    }
    
    func userDeletedName(position: Int) -> Bool {
        do{
            dataModel.remove(at: position)
            return true
        }catch{
            return false
        }
        return false
    }
    
   
    func userUpdatedName(position: Int, enteredData: Person) -> Bool{
        //validation class should validate object and not individual attributes
        if Validation.isValidString(enteredData.firstName) &&
            Validation.isValidString(enteredData.lastName) &&
            Validation.isValidPhoneNumber(enteredData.phoneNumber) &&
            Validation.isNotDuplicate(dataModel,enteredData){
            do{
                dataModel[position] = enteredData
                return true
            }
            catch{
                return false
            }
        }
        return false
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTableViewCell
        cell.contactsName.text = dataModel[indexPath.row].firstName + " " + dataModel[indexPath.row].lastName
        cell.contactsPhoneNumber.text = dataModel[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count//contactNamesList.count
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //do it in storyboard if possible
        myTableView.tableFooterView = UIView()
        //DataModel.read()
        
        //no hardcoding data , show no contacts screen
        dataModel = [a,b,c]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //no unnecessary variables
        selectedRow = indexPath.row
        
        
        
        selectedContactName = dataModel[indexPath.row].firstName
        selectedContactLastName = dataModel[indexPath.row].lastName
        selectedContactPhoneNumber = dataModel[indexPath.row].phoneNumber
        selectedIndexRow = indexPath.row
        
        //instead of passing individual attributes , pass the entire object using index
        
        //performSegue(withIdentifier: "gotoDetailsScreenSegue", sender: self)
        let editViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(editViewController!, animated: true)
        editViewController?.contactLastName = selectedContactLastName
        editViewController?.contactName = selectedContactName
        editViewController?.contactPhoneNumber = selectedContactPhoneNumber
        editViewController?.selectedIndexRow = selectedIndexRow
        editViewController?.updatedName = self
        editViewController?.deletedName = self
        
        
    }
    
    //remove unwanted functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "gotoDetailsScreenSegue"{
//            let destVC = segue.destination as! DetailViewController
//            destVC.contactName = selectedContactName
//            //destVC.delegate = self
//        }
//
//    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let addContactViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:"AddViewController") as? AddContactViewController
       
        self.navigationController?.pushViewController(addContactViewController!, animated: true)
         addContactViewController?.createdName = self
    }
}

extension ViewController: SampleProtocol{
    //functions belonging to this protocol
}

/*
 IBOutlets
 Variables
 Lifecycle Functions
 Functions
 IBactios
 
 extensions
 */

