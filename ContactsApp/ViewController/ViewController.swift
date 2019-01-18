//
//  ViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    
    var dataModel: [Person] = []
    var selectedContactName : String?
    var selectedContactLastName: String?
    var selectedContactPhoneNumber: String?
    var selectedIndexRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //do it in storyboard if possible
        myTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let addContactViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:"AddContactViewController") as? AddContactViewController
       addContactViewController?.createdNameProtocolDelegate = self
        self.navigationController?.pushViewController(addContactViewController!, animated: true)

    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTableViewCell
        let data = dataModel[indexPath.row]
        cell.data = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let editViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(editViewController!, animated: true)
        
        editViewController?.currentPerson = dataModel[indexPath.row]
        editViewController?.selectedIndexRow = indexPath.row
        
        editViewController?.updatedNameProtocolDelegate = self
        editViewController?.deletedNameProtocolDelegate = self
    }
}

extension ViewController: UpdateNameProtocol{
    //functions belonging to this protocol
    func userUpdatedName(position: Int, enteredData: Person) -> Bool{
        if Validation.validatePerson(dataModel, enteredData){
            dataModel[position] = enteredData
            return true
        }
        return false
    }
}

extension ViewController: DeleteNameProtocol{
    func userDeletedName(position: Int) -> Bool {
        do{
            dataModel.remove(at: position)
            return true
        }catch{
            return false
        }
        return false
    }
}

extension ViewController: CreateNameProtocol{
    func userCreatedName(enteredData: Person) -> Bool {
        if Validation.validatePerson(dataModel, enteredData){
            dataModel.append(enteredData)
            return true
        }
        return false
    }
}

/*
 IBOutlets
 Variables
 Lifecycle Functions
 Functions
 IBactios
 
 extensions
 */

