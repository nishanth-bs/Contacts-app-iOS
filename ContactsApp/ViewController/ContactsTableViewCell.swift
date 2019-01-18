//
//  ContactsTableViewCell.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactsName: UILabel!
    @IBOutlet weak var contactsPhoneNumber: UILabel!
    
   //didSet
    var data: Person?{
        didSet{
            if let name = data?.firstName, let nameLast = data?.lastName, let phoneNumber = data?.phoneNumber{
                contactsName.text = name + " " + nameLast
                contactsPhoneNumber.text = phoneNumber
            }
            
        }
    }
    
}
