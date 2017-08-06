//
//  NotificationExtensions.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 8/2/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation


extension Notification.Name {
    static let AccessTokenReceivedNotification = Notification.Name("AccessTokenReceived")
    static let UserIdReceivedNotification = Notification.Name("UserIdReceived")
    static let UserDiariesReceivedNotification = Notification.Name("UserDiariesReceived")
    static let WelcomeCoachReceivedNotification = Notification.Name("WelcomeCoachReceived")
    static let UserAlreadyExistsReceivedNotification = Notification.Name("UserAlreadyExistsReceived")
}
