//
//  ViewController.swift
//  SimpleCRUD
//
//  Created by Saravanakumar TIruthani on 10/8/14.
//  Copyright (c) 2014 Kukumber. All rights reserved.
//

import UIKit
import CoreData

let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var allowance: UITextField!
    
    @IBOutlet weak var status: UILabel!
    
    
    @IBAction func onCreate(sender: AnyObject) {
        
        var eD = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        var fr = NSFetchRequest()
        fr.entity    = eD
        fr.predicate = NSPredicate(format: "name == %@", name.text)
        var error = NSErrorPointer()
        
        
        var result = managedObjectContext?.executeFetchRequest(fr, error: error)
        if result == nil {
            status.text = "Unknown Error \(error.debugDescription)"
            return
        }
        
        if( result?.count != 0 ) {
                status.text = "Record already exists"
                return
        }
        
        var person = Person(entity: eD!, insertIntoManagedObjectContext: managedObjectContext!)
        person.name = name.text
        person.allowance = allowance.text.toInt()!
        managedObjectContext?.save(error)
        status.text = "New record created"
    }

    
    @IBAction func onRead(sender: AnyObject) {

        var fr = NSFetchRequest()
        fr.entity    = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        fr.predicate = NSPredicate(format: "name == %@", name.text)
        var result = managedObjectContext?.executeFetchRequest(fr, error: nil)
      
        if result == nil {
            status.text = "Unknown error while fetching"
            return
        }
        var person = result! as [Person]
        if person.count == 0 {
            status.text = "No record matching \(name.text)"
            return
        }
        
        status.text = "Successfully read \(person.count) records matching \(name.text)"
        for  p in person {
            println( "\(p.name)  \(p.allowance)")
            allowance.text = "\(p.allowance)"
        }
    }
   
    @IBAction func onUpdate(sender: AnyObject) {
        var eD = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        var fr = NSFetchRequest()
        fr.entity    = eD
        fr.predicate = NSPredicate(format: "name == %@", name.text)
        var error = NSErrorPointer()
        
        
        var result = managedObjectContext?.executeFetchRequest(fr, error: nil)
        if result == nil {
            status.text = "Unknown Error"
            return
        }
        
        if( result?.count == 0 ) {
            status.text = "There is no record with name = \(name.text)"
            return
        }
        
        if( result?.count > 1 ) {
            status.text = "Oopps.. there is more than one record with name = \(name.text)"
            return
        }
        
        
        var person = result! as [Person]
        var p = person[0]
        var p1 = p.objectID
        
        var updatedPerson = managedObjectContext?.existingObjectWithID(p1, error:error) as Person
        
        updatedPerson.allowance = allowance.text.toInt()!
        managedObjectContext?.save(error)
        status.text = "\(name.text) updated with \(allowance.text)"
    }
    
    
    @IBAction func onDelete(sender: AnyObject) {
        var eD = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        var fr = NSFetchRequest()
        fr.entity    = eD
        fr.predicate = NSPredicate(format: "name == %@", name.text)
        var error = NSErrorPointer()
        
        
        var result = managedObjectContext?.executeFetchRequest(fr, error: nil)
        if result == nil {
            status.text = "Unknown Error"
            return
        }
        
        if( result?.count == 0 ) {
            status.text = "There is no record with name = \(name.text)"
            return
        }
        
        if( result?.count > 1 ) {
            status.text = "Oopps.. there is more than one record with name = \(name.text)"
            return
        }
        
        
        var person = result! as [Person]
        var p = person[0]
        var p1 = p.objectID
        
        var toDeletePerson = managedObjectContext?.existingObjectWithID(p1, error:error) as Person
        managedObjectContext?.deleteObject(toDeletePerson)
        managedObjectContext?.save(error)
        
        status.text = "\(name.text) deleted"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

