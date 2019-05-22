//
//  ClientController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class ClientController {
    
    let clients: [Client] = []
    var bearer: Bearer?
    //get the base url
    private let baseURL = URL(string: "https://anywhere-fitness.herokuapp.com/")!
    
    
    
    func signUp(client: Client, completion: @escaping (Error?) -> Void){
        //endpoints are /auth/register
        let endPointUrl = baseURL.appendingPathComponent("auth").appendingPathComponent("register")
        
        //post the information to the api
        var request = URLRequest(url: endPointUrl)
        request.httpMethod = "POST"
        //do i need to set value for the the http header?
        request.setValue("appliication/json", forHTTPHeaderField: "Content-Type")
        
        let je = JSONEncoder()
        
        do {
            let jsonData = try je.encode(client)
            request.httpBody = jsonData
        } catch  {
            print("Encoding httpBody: \(error.localizedDescription)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error with network call to post client: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("problem with data: \(NSError())")
                completion(NSError())
                return }
            
            //the data we are getting back per the api should be the token
            let jD = JSONDecoder()
            
            do {
                self.bearer = try jD.decode(Bearer.self, from: data)
            } catch {
                print("Error decoding the data: \(error.localizedDescription)")
                completion(error)
                return
            }
        }
        
        
    }
    
    
    
}
