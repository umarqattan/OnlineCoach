//
//  CoachClient.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 8/1/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation

import Foundation

class CoachClient {
    
    var diary:Diary!
    
    init(foods:[FoodDiaryEntry], exercises:[ExerciseDiaryEntry]) {
        self.diary = Diary(foods: foods, exercises: exercises)
    }
    
    
    
    struct Diary {
        var foods:[FoodDiaryEntry]
        var exercises:[ExerciseDiaryEntry]
    }
    
    
    
}

