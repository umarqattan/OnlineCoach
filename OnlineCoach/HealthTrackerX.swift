////
////  HealthTrackerX.swift
////  OnlineCoach
////
////  Created by Umar Qattan on 7/28/17.
////  Copyright © 2017 Umar Qattan. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//class HealthTrackerX {
//    
//    /**
//        1. make an HTTP POST request with a username and password in order to get a token
//        getToken from url: https://healthtrackerx.azurewebsites.net/Token
//     
//        2. make an HTTP GET request with an access token and token type in order to get a 
//        clientUserId from https://healthtrackerx.azurewebsites.net/api/Client/Get
//     
//        3. make an HTTP GET request with an access token, token type, and clientUserId to get all clients for a particular coach https://healthtrackerx.azurewebsites.net/api/Diary/Get/?uid={clientUserId}
//
//     
//    **/
//    static let config = URLSessionConfiguration.default
//    static let session = URLSession(configuration: config)
//    
//    
//    
//    
//    struct URLComponent {
//        
//        static let Token:String = "Token"
//        static let API:String = "api"
//        static let POST:String = "POST"
//        static let GET:String = "Get"
//        static let baseURL:String = "https://healthtrackerx.azurewebsites.net/"
//        static let Client:String = "Client"
//        static let Diary:String = "Diary"
//        static let query:String = "?uid="
//    }
//    
//    
//    struct Header {
//        
//        enum Option:Int {
//            case Token = 0
//            case ClientId = 1
//            case Diary = 2
//        }
//        
//        let Token:[String:String] = [
//            "content-type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache"
//        ]
//        
//        func ClientId(accessToken:String, tokenType:String) -> [String:String] {
//            return  [
//            "authorization" : "\(tokenType.capitalized) \(accessToken)",
//            "cache-control" : "no-cache"
//            ]
//        }
//        
//        func Diary(accessToken:String, tokenType:String) -> [String:String] {
//            return  [
//                "authorization" : "\(tokenType.capitalized) \(accessToken)",
//                "cache-control" : "no-cache"
//            ]
//        }
//    }
//    
//    enum Method : String {
//        case GET = "Get"
//        case POST = "POST"
//    }
//    
//    
//    static func buildHTTPHeader(option:Int, accessToken:String?, tokenType:String?) -> [String:String] {
//        switch option {
//            case Header.Option.Token.rawValue:
//                return Header().Token
//            case Header.Option.ClientId.rawValue:
//                return Header().ClientId(accessToken: accessToken!, tokenType: tokenType!)
//            case Header.Option.Diary.rawValue:
//                return Header().Diary(accessToken: accessToken!, tokenType: tokenType!)
//            default: return ["":""]
//        }
//    }
//    
//    func buildTask(request: URLRequest, completionHandler : @escaping (_ result: Data?, _ error: Error?) -> Void) -> URLSessionDataTask {
//        let task = HealthTrackerX.session.dataTask(with: request) { data, response, downloadError in
//            if let error = downloadError {
//                completionHandler(nil, error)
//            } else {
//                completionHandler(data, nil)
//            }
//        }
//        task.resume()
//        return task
//    }
//      
//    func getRequest(baseURL: String, api: String, option:Int,  headers: [String:String], clientUserId: String?) -> URLRequest {
//
//        let url = buildURL(baseURL: baseURL, option: option, clientUserId: clientUserId)
//        
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = headers
//        
//        return request
//    }
//    
//    func postRequest(baseURL: String, api: String, option: Int, body : [String:Any], headers: [String:String], clientUserId: String?) -> URLRequest? {
//        
//        var request = getRequest(baseURL: baseURL, api: api, option: option, headers: headers, clientUserId: clientUserId)
//        request.httpMethod = Method.POST.rawValue
//        do {
//            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        
//        }
//        
//        return request
//    }
//    
//    func getCoachToken(body:[String:String], completionHandler: @escaping (_ success:Bool, _ accessToken:String?, _ tokenType:String?, _ error:String?) -> Void) -> Void {
//        
//        let headers = Header().Token
//        let request = postRequest(baseURL: URLComponent.baseURL, api: URLComponent.API, option: Header.Option.Token.rawValue, body: body, headers: headers, clientUserId: nil)!
//        let task = buildTask(request: request) { (data, downloadError) in
//            
//            if let error = downloadError {
//                completionHandler(false, nil, nil, error.localizedDescription)
//            } else {
//                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
//                let accessToken = (jsonObject as! [String:Any])["access_token"] as! String
//                let tokenType = (jsonObject as! [String:Any])["token_type"] as! String
//                completionHandler(true, accessToken, tokenType, nil)
//                
//            }
//        }
//    }
//    
//    func buildAccessTokenBody(username: String, password: String) -> [String:String]{
//        return [ "grant_type" : "password",
//                 "username":username,
//                 "password":password
//        ]
//    }
//
//    func getCoachClient(username: String, password:String, completionHandler: @escaping (_ success:Bool, _ clientsDiaries:[CoachClient]?) -> Void) {
//        let body = buildAccessTokenBody(username: username, password: password)
//        
//        getCoachToken(body: body) { (success, accessToken, tokenType, error) in
//            
//            if success {
//            
//                self.getClientFrom(accessToken: accessToken!, tokenType: tokenType!) { (success, accessToken, tokenType, clientUserId) in
//                    if success {
//                        
//                        self.getDiaryFrom(accessToken: accessToken!, tokenType: tokenType!, clientUserId: clientUserId!) { (success, clientsDiaries) in
//                            if success {
//                                completionHandler(true, clientsDiaries)
//                            } else {
//                                completionHandler(false, nil)
//                            }
//                        }
//                    } else {
//                        completionHandler(false, nil)
//                    }
//                }
//            } else {
//                completionHandler(false, nil)
//            }
//        }
//    }
//    
//    
//
//    func getClientFrom(accessToken:String, tokenType:String, completionHandler: @escaping (_ success:Bool, _ accessToken:String?, _ tokenType:String?, _ clientUserId:String?) -> Void) -> Void {
//        let headers = Header().ClientId(accessToken: accessToken, tokenType: tokenType)
//        let request = getRequest(baseURL: URLComponent.baseURL, api: URLComponent.API, option: Header.Option.ClientId.rawValue, headers: headers, clientUserId: nil)
//        
//        let task = buildTask(request: request) { (data, downloadError) in
//            
//            if let error = downloadError {
//                
//                completionHandler(false, nil, nil, error.localizedDescription)
//            } else {
//                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
//                let clientUserId = ((jsonObject! as! [Any])[0] as! [String:Any])["clientUserId"] as! String
//                completionHandler(true, accessToken, tokenType, clientUserId)
//            }
//        }
//        
//    }
//    
//    func getDiaryFrom(accessToken:String, tokenType:String, clientUserId:String, completionHandler: @escaping (_ success:Bool, _ clientsDiaries:[CoachClient]?) -> Void) -> Void {
//        let headers = Header().Diary(accessToken: accessToken, tokenType: tokenType)
//        
//        let request = getRequest(baseURL: URLComponent.baseURL, api: URLComponent.API, option: Header.Option.Diary.rawValue, headers: headers, clientUserId: clientUserId)
//        let task = buildTask(request: request) { (data, downloadError) in
//            
//            if let error = downloadError {
//                completionHandler(false, nil)
//            } else {
//                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
//                var clients:[CoachClient] = []
//                let clientsDiaries = (jsonObject as! [Any]) as! [[String:Any]]
//                for clientDiary in clientsDiaries {
//
//                    let foods = clientDiary["joinedFoodEntry"] as! [[String:Any]]
//                    let exercises = clientDiary["joinedExerciseEntry"] as! [[String:Any]]
//
//                    var foodDiaryEntries:[FoodDiaryEntry] = []
//                    var exerciseDiaryEntries:[ExerciseDiaryEntry] = []
//
//                    for food in foods {
//                        foodDiaryEntries.append(FoodDiaryEntry(data: food))
//                    }
//                    for exercise in exercises {
//                        exerciseDiaryEntries.append(ExerciseDiaryEntry(data: exercise))
//                    }
//                    
//                    let client:CoachClient = CoachClient(foods: foodDiaryEntries, exercises: exerciseDiaryEntries)
//                    
//                    clients.append(client)
//                    completionHandler(true, clients)
//                }
//            }
//        }
//        
//    }
//    
//    func buildURL(baseURL:String, option:Int, clientUserId:String?) -> URL {
//        
//        let tokenURL = URL(string: "\(baseURL+URLComponent.Token)")!
//        
//        let clientUserIdURL = URL(string: "\(baseURL+URLComponent.API)/\(URLComponent.Client)/\(Method.GET.rawValue)")!
//        
//        
//        switch option {
//            case Header.Option.Token.rawValue:
//                return tokenURL
//            case Header.Option.ClientId.rawValue:
//                return clientUserIdURL
//            case Header.Option.Diary.rawValue:
//                return URL(string: "\(baseURL+URLComponent.API)/\(URLComponent.Diary)/\(URLComponent.Client)/\(Method.GET.rawValue)/\(URLComponent.query+clientUserId!)")!
//            default:
//                return URL(string: baseURL)!
//        }
//    }
//    
//
//    
//    
//}
