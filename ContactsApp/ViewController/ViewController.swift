//
//  ViewController.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var selectedRow = 0
    var selectedContactName : String = ""
    var selectedContactLastName: String = ""
    var selectedContactPhoneNumber: String = ""
    var selectedIndexRow: Int = 0

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTableViewCell
        cell.contactsName.text = DataModel.dataModel[indexPath.row].firstName + " " + DataModel.dataModel[indexPath.row].lastName
        cell.contactsPhoneNumber.text = DataModel.dataModel[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.dataModel.count//contactNamesList.count
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.tableFooterView = UIView()
        DataModel.read()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow = indexPath.row
        selectedContactName = DataModel.dataModel[indexPath.row].firstName
        selectedContactLastName = DataModel.dataModel[indexPath.row].lastName
        selectedContactPhoneNumber = DataModel.dataModel[indexPath.row].phoneNumber
        selectedIndexRow = indexPath.row
        
        //performSegue(withIdentifier: "gotoDetailsScreenSegue", sender: self)
        let editViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(editViewController!, animated: true)
        editViewController?.contactLastName = selectedContactLastName
        editViewController?.contactName = selectedContactName
        editViewController?.contactPhoneNumber = selectedContactPhoneNumber
        editViewController?.selectedIndexRow = selectedIndexRow
        
    }
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
    }
    

}

