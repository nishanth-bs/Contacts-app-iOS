//
//  DataModel.swift
//  ContactsApp
//
//  Created by Nishanth B S on 17/01/19.
//  Copyright © 2019 Nishanth B S. All rights reserved.
//

import UIKit
import CoreData

class DataModel {
    static var dataModel: [Person] = []
    
    static func add(_ enteredData: Person) -> Bool{
        
        if Validation.isValidString(enteredData.firstName) &&
            Validation.isValidString(enteredData.lastName) &&
            Validation.isValidPhoneNumber(enteredData.phoneNumber) &&
            Validation.isNotDuplicate(dataModel,enteredData){
            //dataModel.append(enteredData)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
            
            // create context from the container
            let managedContext = appDelegate.persistentContainer.viewContext
            // 2
            let entity = NSEntityDescription.entity(forEntityName: "IndividualContact", in: managedContext)!
            let person = NSManagedObject(entity: entity, insertInto: managedContext)
            person.setValue(enteredData.firstName, forKeyPath: "firstName")
            person.setValue(enteredData.lastName, forKeyPath: "lastName")
            person.setValue(enteredData.phoneNumber, forKeyPath: "phoneNumber")
            
            // 4
            do {
                try managedContext.save()
                read()
                //people.append(person)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return false
            }
            return true
        }
        return false
    }
    
    static func updateAt(position: Int, enteredData: Person) -> Bool{
        if Validation.isValidString(enteredData.firstName) &&
            Validation.isValidString(enteredData.lastName) &&
            Validation.isValidPhoneNumber(enteredData.phoneNumber) &&
            Validation.isNotDuplicate(dataModel,enteredData){
            do{
                //dataModel[position] = enteredData
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "IndividualContact")
                fetchRequest.predicate = NSPredicate(format: "firstName= %@", dataModel[position].firstName)
                
                do{
                    let test = try managedContext.fetch(fetchRequest)
                    
                    let objectiveUpdate = test[0] as! NSManagedObject
                    objectiveUpdate.setValue(enteredData.firstName, forKey: "firstName")
                    objectiveUpdate.setValue(enteredData.lastName, forKey: "lastName")
                    objectiveUpdate.setValue(enteredData.phoneNumber, forKey: "phoneNumber")
                    do{
                        try managedContext.save()
                        read()
                    }catch{
                        return false
                    }
                }catch{
                    return false
                }
                return true
            }catch{
                return false
            }
        }
return false
    }
    
    static func removeAt(position: Int) -> Bool{
        do{
            //dataModel.remove(at: position)
            //dataModel[position] = enteredData
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "IndividualContact")
            fetchRequest.predicate = NSPredicate(format: "firstName= %@", dataModel[position].firstName)

            do{
                let test = try managedContext.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                
                do{
                    try managedContext.save()
                    read()
                }catch{
                    return false
                }
            }catch{
                return false
            }
            return true
        }catch{
            return false
        }
    }
    
    static func read(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IndividualContact")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            dataModel = []
            for data in result as! [NSManagedObject]{
                let firstName = data.value(forKey: "firstName") as! String
                let lastName = data.value(forKey: "lastName") as! String
                let phoneNumber = data.value(forKey: "phoneNumber") as! String
                let insertedData = Person(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                
                dataModel.append(insertedData)
            }
//            let people = try managedContext.fetch(fetchRequest)
//            print(people)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

