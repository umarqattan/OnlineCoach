//
//  Food.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/26/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Food: NSManagedObject {
    
    @NSManaged var name:String?
    @NSManaged var id:String?
    @NSManaged var servingSizeUnits:String?
    @NSManaged var servingSize:Int16
    @NSManaged var calories:Int16
    @NSManaged var fat:Int16
    @NSManaged var carb:Int16
    @NSManaged var protein:Int16
    @NSManaged var fiber:Int16
    
    
    
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    convenience init(data:[String:Any]?, entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: context)
        
        name = data?["foodName"] as? String
        id = data?["foodId"] as? String
        servingSizeUnits = data?["servingSizeUnits"] as? String
        servingSize = (data?["servingSize"] as? Int16)!
        calories = (data?["calories"] as? Int16)!
        fat = (data?["fat"] as? Int16)!
        carb = (data?["carb"] as? Int16)!
        protein = (data?["protein"] as? Int16)!
        fiber = (data?["fiber"] as? Int16)!
        
    }
    
}
