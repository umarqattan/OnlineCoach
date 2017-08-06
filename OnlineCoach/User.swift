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


    
    
    
    @NSManaged var birthdate:String
    @NSManaged var myUserId:String
    @NSManaged var emailAddress:String
    @NSManaged var firstName:String
    @NSManaged var lastName:String
    @NSManaged var intensity:Int16
    @NSManaged var isCoach:Bool
    
    @NSManaged var phoneNumber:String
    @NSManaged var height:Int16
    @NSManaged var weight:Float
    @NSManaged var isMetric:Bool
    @NSManaged var password:String
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(data:[String:Any], entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: context)
        
        
        
        birthdate = data["birthdate"] as! String
        myUserId = data["myUserId"] as! String
        intensity = data["intensity"] as! Int16
        firstName = data["firstName"] as! String
        lastName = data["lastName"] as! String
        emailAddress = data["emailAddress"] as! String
        isCoach = data["isCoach"] as! Bool
        phoneNumber = data["phoneNumber"] as! String
        height = data["height"] as! Int16
        isMetric = data["isMetric"] as! Bool
        password = data["password"] as! String
        weight = data["weight"] as! Float
    
    }
    
}
