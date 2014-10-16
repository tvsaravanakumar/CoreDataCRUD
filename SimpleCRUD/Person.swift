//
//  Person.swift
//  SimpleCRUD
//
//  Created by Saravanakumar TIruthani on 10/8/14.
//  Copyright (c) 2014 Kukumber. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var allowance: NSNumber

}
