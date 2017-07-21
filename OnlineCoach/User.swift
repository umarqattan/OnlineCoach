//
//  User.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/20/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class User: NSManagedObject {

    @NSManaged var firstName:String?
    @NSManaged var lastName:String?
    @NSManaged var emailAddress:String?
    @NSManaged var phoneNumber:String?
    @NSManaged var isClient:Bool
    @NSManaged var isCoach:Bool
    @NSManaged var height:String?
    @NSManaged var weight:Float
    @NSManaged var age:Int16
    @NSManaged var unit:String?
    @NSManaged var goal:String?
    
    
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(data:[String:Any]?, entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: context)
        
        firstName = data?["firstName"] as? String
        lastName = data?["lastName"] as? String
        emailAddress = data?["emailAddress"] as? String
        phoneNumber = data?["phoneNumber"] as? String
        isClient = data?["isClient"] as! Bool
        isCoach = data?["isCoach"] as! Bool
        height = data?["height"] as? String
        weight = data?["weight"] as! Float
        age = data?["age"] as! Int16
        unit = data?["unit"] as? String
        goal = data?["goal"] as? String
        
    }
    
}
