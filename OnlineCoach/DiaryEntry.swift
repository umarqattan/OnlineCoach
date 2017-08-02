//
//  DiaryEntry.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 8/1/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation





class ExerciseDiaryEntry {
    
    var complete:Bool!
    var date:String!
    var exerciseName:String!
    var reps:Int16!
    var sets:Int16!
    var weight:Int16!
    
    init(data:[String:Any]) {
        complete = data["complete"] as! Bool
        date = data["diaryDate"] as! String
        exerciseName = data["exerciseName"] as! String
        reps = data["reps"] as! Int16
        sets = data["sets"] as! Int16
        weight = data["weight"] as! Int16
    }
    
    func description() -> String {
        return "Exercise Name: \(exerciseName!)\n" + "\(weight!) lbs for \(sets!) sets X \(reps!) reps\n\n"
    }
    
    
}


class FoodDiaryEntry {
    
    
    var complete:Bool!
    var date:String!
    var calories:Int16!
    var fat:Int16!
    var carbs:Int16!
    var protein:Int16!
    var fiber:Int16!
    var mealNum:Int16!
    var numberOfServings:Float!
    var servingSize:Float!
    var servingSizeUnits:String!
    var mealName:String!
    var foodName:String!
    
    init(data:[String:Any]) {
        complete = data["complete"] as! Bool
        date = data["diaryDate"] as! String
        calories = data["calories"] as! Int16
        fat = data["fat"] as! Int16
        carbs = data["carbs"] as! Int16
        protein = data["protein"] as! Int16
        fiber = data["fiber"] as! Int16
        mealNum = data["mealNum"] as! Int16
        numberOfServings = data["numberOfServings"] as! Float
        servingSize = data["servingSize"] as! Float
        servingSizeUnits = data["servingsSizeUnits"] as! String
        mealName = data["mealName"] as! String
        foodName = data["foodName"] as! String
    }
    
    
    func description() -> String {
        return "Meal Number \(mealNum!): \(mealName!)\n" + "Food Name: \(foodName!)\n" + "Quantity: \(numberOfServings! * servingSize!) \(servingSizeUnits!)\n" + "Calories: \(servingSize*Float(calories!))\n" + "Fat: \(fat!)g\n" + "Carbs: \(carbs!)g\n" + "Protein: \(protein!)g\n" + "Fiber: \(fiber!)g\n\n"
        
    }
    
    
}



