//
//  NewUser.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/19/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation
import CoreData

class NewUser:NSObject {
    
    
    var firstName:String?
    var lastName:String?
    var height:String?
    var weight:String?
    var isClient:Bool?
    var isCoach:Bool?
    var phoneNumber:String?
    var unit:String?
    
    
    init(data:[String:Any]) {
        firstName = data["firstName"] as? String
        lastName = data["lastName"] as? String
        height = data["height"] as? String
        weight = data["weight"] as? String
        isClient = data["isClient"] as? Bool
        isCoach = data["isCoach"] as? Bool
        phoneNumber = data["phoneNumber"] as? String
        unit = data["unit"] as? String
        
    }

}

