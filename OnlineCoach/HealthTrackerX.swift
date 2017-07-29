//
//  HealthTrackerX.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/28/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HealthTrackerX {
    
    
    let Token:String = "Token"
    let API:String = "api"
    let POST:String = "POST"
    let GET:String = "Get"
    let baseURL:String = "https://healthtrackerx.azurewebsites.net/"
    let Client:String = "Client"
    let Diary:String = "Diary"
    let query:String = "?uid="
    
    
    
    func login(username: String, password:String) {
        getToken(username: username, password: password)
    }
    
    func getToken(username: String, password:String) {
        
        let tokenHeaders = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        
        var accessToken:String!
        var tokenType:String!
        
        let tokenPostData = NSMutableData(data: "grant_type=password".data(using: .utf8)!)
        tokenPostData.append("&username=\(username)".data(using: .utf8)!)
        tokenPostData.append("&password=\(password)".data(using: .utf8)!)
        
        let tokenURL = NSURL(string: baseURL+Token)! as URL
        var request = NSMutableURLRequest(url: tokenURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
        
        request.httpMethod = POST
        request.allHTTPHeaderFields = tokenHeaders
        request.httpBody = tokenPostData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                if let jsonToken = jsonObject as? [String:Any] {
                    if let t_accessToken = jsonToken["access_token"] as? String, let t_tokenType = jsonToken["tokenType"] as? String {
                        accessToken = t_accessToken
                        tokenType = t_tokenType
                        print("GOT TOKEN: \(accessToken)")
                        HealthTrackerX().getClient(from: accessToken, tokenType: tokenType)
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func getClient(from accessToken:String, tokenType:String) {
        
        var clientUserId:String!
        
        let clientHeaders = [
            "authorization" : "\(tokenType.capitalized) \(accessToken)",
            "cache-control" : "no-cache"
        ]
        
        let clientURL = NSURL(string: baseURL+API+"/"+Client+"/"+GET)! as URL
        
        let request = NSMutableURLRequest(url: clientURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = GET.uppercased()
        request.allHTTPHeaderFields = clientHeaders
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                if let jsonClient = jsonObject as? [String:Any] {
                    if let t_clientUserId = jsonClient["clientUserId"] as? String {
                        clientUserId = t_clientUserId
                        
                        HealthTrackerX().getClientDiary(from: clientUserId, accessToken: accessToken, tokenType: tokenType, completionHandler: { (clientFoodDiary, clientExerciseDiary) -> Void in
                            
                        })
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    
    func getClientDiary(from clientUserId:String, accessToken:String, tokenType:String, completionHandler:@escaping (_ clientFoodDiary: [[String:Any]]?, _ clientExerciseDiary:[[String:Any]]?)->Void) -> Void {
        
        var client:[String:Any]!
        var clientFoodDiary:[[String:Any]]!
        var clientExerciseDiary:[[String:Any]]!
        
        let clientDiaryHeaders = [
            
            "authorization" : "\(tokenType.capitalized) \(accessToken)",
            "cache-control" : "no-cache"
        ]
        
        let clientURL = NSURL(string: baseURL+API+"/"+Diary+"/"+GET+"/"+query+clientUserId)! as URL
        
        let request = NSMutableURLRequest(url: clientURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = GET.uppercased()
        request.allHTTPHeaderFields = clientDiaryHeaders
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                if let jsonClient = jsonObject as? [[String:Any]] {
                    if let t_client = jsonClient.first {
                        client = t_client
                        if let t_clientFoodDiary = t_client["joinedFoodEntry"] as? [[String:Any]] {
                            clientFoodDiary = t_clientFoodDiary
                            
                        }
                        if let t_clientExerciseDiary = t_client["joinedExerciseEntry"] as? [[String:Any]] {
                            clientExerciseDiary = t_clientExerciseDiary
                        }
                        print("CLIENT: \(client)")
                        print("CLIENT FOOD DIARY: \(clientFoodDiary)")
                        print("CLIENT EXERCISE DIARY: \(clientExerciseDiary)")

                        print("Finally...")
                        completionHandler(clientFoodDiary, clientExerciseDiary)
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    var foods:[Food] = []
    
    func getFoods() {
        let urlString:String = "https://healthtrackerx.azurewebsites.net/api/Foods"
        let url:URL = URL(string: urlString)!
        let httpMethod:String = "GET"
        let contentType:String = "application/json"
        let cacheControl:String = "no-cache"
        let contentLength = "0"
        
        let allHeaderFields:[String: String]? = [
            "content-type" : contentType,
            "cache-control":cacheControl,
            "content-length": contentLength
        ]
        
        do {
            let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = httpMethod
            request.allHTTPHeaderFields = allHeaderFields
            request.httpBody = nil
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error!)
                } else {
                    let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                    
                    if let jsonFoods = jsonObject as? [[String:Any]] {
                        
                        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let entity = NSEntityDescription.entity(forEntityName: "Food", in: context)
                        
                        for food in jsonFoods {
                            
                            self.foods.append(Food(data: food, entity: entity!, insertInto: context))
                        }
                        appDelegate.saveContext()
                        
                    }
                }
            })
            dataTask.resume()
        }
        
    }

}

