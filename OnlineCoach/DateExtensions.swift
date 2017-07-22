//
//  DateExtensions.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/22/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation

extension Date {
    var age: Int16 {
        return Int16(Calendar.current.dateComponents([.year], from: self, to: Date()).year!)
    }
}
